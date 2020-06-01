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

  function writeArithmetic(String $command ) {
    // Read top of stack to D
    $this->write([
      "// ==== $command ====",
      "// pop starts",
      "@SP",
      "A=M-1",
      "D=M",
      "// pop ends",
      "// inner $command starts",
      'A=A-1',
    ]);
    switch ($command) {
      case 'add':
        // But add it to previous D this time
        $this->write([
          "M=D+M"
        ]);
        break;

      case 'eq':
        $jumpPointer = $this->ic+5;
        $this->write([
          'D=M-D', // ic
          'M=0', // set M=0, in case they aren't equal
          "@{jumpPointer}",
          'D;JEQ', //ic+2
          'M=0',   //ic+3
          'M=M-1', //ic+4
          // set M=-1 (TRUE), in case they are equal
          // *SP=-1 = true
        ]);

      default:
        # code...
        break;
    }

    $this->write([
      '@SP',
      'M=M-1'
    ]);
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
          "// push $segment $index",
          // Take the constant
          "@$index",
          // Write it to D
          "D=A",
          // A=SP
          "@SP",
          "A=M",
          // Write D to SP
          "M=D",
          // Bump Stack Pointer
          "@SP",
          "M=M+1",
          "// end push $segment $index"
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
