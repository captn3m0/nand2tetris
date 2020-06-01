<?php

namespace captn3m0\NandToTetris;

class CommandType {
  const CALL = 0;
  const PUSH = 1;
  const POP = 2;
  const LABEL= 3;
  const GOTO= 4;
  const IF= 5;
  const FUNC= 6;
  const RETURN= 7;
  const ARITHMETIC= 8;

  const ARITHMETIC_COMMANDS = ['add', 'sub', 'neg', 'eq', 'gt', 'lt', 'and', 'or', 'not'];

  public static function fromName(String $name) {
    if(in_array($name, self::ARITHMETIC_COMMANDS)) {
      return self::ARITHMETIC;
    } else {
      $map = ["call","push","pop","label","goto","if","func","return"];
      return array_search($name, $map);
    }
  }
}

class Parser {
  function __construct(String $inputFile ) {
    $this->file = fopen($inputFile, "r");
  }

  function arg1() {
    assert($this->command !== CommandType::RETURN);

    return $this->pieces[1];
  }

  function arg2() {
    assert(in_array($this->command, [CommandType::PUSH, CommandType::POP, CommandType::FUNC, CommandType::CALL]));
    return $this->pieces[2];
  }

  private function stripComment(String $line) {
    $index = strpos($line, '//');
    if ($index === 0) {
      return '';
    }
    if ($index !== false) {
      return substr($line, 0, $index-1);
    } else {
      return $line;
    }
  }

  function commands() {
    while(!feof($this->file)) {
      $line = fgets($this->file);
      $line = $this->stripComment(trim($line));
      if (empty($line))continue;
      $this->pieces = explode(" ", $line);
      $this->command = $this->pieces[0];
      yield $this->command;
    }
    fclose($this->file);
  }
}

class CodeWriter {
  function __construct($outputFile) {
    $this->ic = 0;
    $this->file = fopen($outputFile, "w");
  }

  function __destruct() {
    fclose($this->file);
  }

  function close() {
    $endJump = $this->ic+1;
    $this->write([
      "@$endJump",
      "0;JMP"
    ]);
  }

  function writeArithmetic(String $command ) {
    $stackDecrease=true;
    // Read top of stack to D
    $this->write([
      "@SP // ==== $command ====",
      "A=M-1",
      "D=M"
    ]);

    switch ($command) {
      case 'sub':
        $this->write([
          'A=A-1',
          "M=M-D",
        ]);
        break;

      case 'add':
        // But add it to previous D this time
        $this->write([
          'A=A-1',
          'M=D+M'
        ]);
        break;

      case 'neg':
        $this->write([
          'M=-M',
        ]);
        $stackDecrease = false;
        break;


      case 'not':
        $this->write([
          'M=!M',
        ]);
        $stackDecrease = false;
        break;

      case 'and':
        $this->write([
          'A=A-1',
          'M=D&M',
        ]);
        break;

      case 'or':
        $this->write([
          'A=A-1',
          'M=D|M',
        ]);
        break;

      case 'lt':
        $jumpPointer = $this->ic+10;
        $this->write([
          'A=A-1',
          'D=M-D',
          'M=0',
          'M=M-1',
          "@$jumpPointer",
          "D;JLT",
          "@SP",
          "A=M-1",
          "A=A-1",
          "M=0",
        ]);
        break;

      case 'gt':
        $jumpPointer = $this->ic+10;
        $this->write([
          'A=A-1',
          'D=M-D',
          'M=0',
          'M=M-1',
          "@$jumpPointer",
          "D;JGT",
          "@SP",
          "A=M-1",
          "A=A-1",
          "M=0",
        ]);
        break;

      case 'eq':
        $jumpPointer = $this->ic+10;
        $this->write([
          'A=A-1',
          'D=M-D',
          'M=0',
          'M=M-1',
          "@{$jumpPointer}",
          'D;JEQ',
          "@SP",
          "A=M-1",
          "A=A-1",
          "M=0",
        ]);
        break;

      default:
      throw new \Exception("$command not Implemented", 1);

    }

    if ($stackDecrease) {
      $this->write([
        '@SP',
        'M=M-1'
      ]);
    }
  }

  private function write(Array $lines) {
    foreach ($lines as $line) {
      if (substr($line, 0, 2) !== "//") {
        $this->ic += 1;
      }
      fwrite($this->file, "$line\n");
    }
  }

  function writePush(String $segment, Int $index) {
    switch ($segment) {
      case 'constant':
        $this->write([
          // Take the constant
          "@$index // push $segment $index",
          // Write it to D
          "D=A",
          // A=SP
          "@SP",
          "A=M",
          // Write D to SP
          "M=D",
          // Bump Stack Pointer
          "@SP",
          "M=M+1 // end push $segment $index",
        ]);
        break;

      default:
        throw new Exception("Not Implemented $segment", 1);
        break;
    }
  }

  function writePushPop(Int $command, String $segment , Int $index) {
    switch ($command) {
      case CommandType::PUSH:
        $this->writePush($segment, $index);
        break;

      case CommandType::POP:

        break;
      default:
        throw new Exception("Invalid Command Type", 1);
        break;
    }
  }
}


class VMTranslator {
  function __construct(String $fileOrDir ) {
    if (is_dir($fileOrDir)) {
      $this->files = glob("$fileOrDir/*.vm");
    } else {
      $this->files = [$fileOrDir];
    }

    foreach ($this->files as $file) {
      assert(is_readable($file));
    }

    $outputFile = $this->outputFile();
    $this->writer = new CodeWriter($outputFile);
  }

  function translate() {
    foreach ($this->files as $file) {
      $parser = new Parser($file);

      foreach ($parser->commands() as $command) {
        $commandType = CommandType::fromName($command);
        switch ($commandType) {
          case CommandType::ARITHMETIC:
            $this->writer->writeArithmetic($command);
            break;

          case CommandType::PUSH:
          case CommandType::POP:
            $segment = $parser->arg1();
            $index = intval($parser->arg2());
            $this->writer->writePushPop($commandType, $segment, $index);
            break;

          default:
            throw new \Exception("Not Implemented $command", 1);
            break;
        }
      }
    }
    $this->writer->close();
  }

  private function outputFile() {
    $dir = dirname($this->files[0]);
    $name = basename($dir);
    return "$dir/$name.asm";
  }
}


if(isset($argv[1])) {
  $vmt = new VMTranslator($argv[1]);
  $vmt->translate();
}
