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
    $this->file = fopen($outputFile, "w");
  }

  function writeArithmetic(String $command ) {
    throw new \Exception("Not yet Implemented");
  }

  function writePushPop(Int $command, String $segment , Int $index) {
    throw new \Exception("Not yet Implemented");
  }

  function close() {
    throw new \Exception("Not yet Implemented");
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
    return '/tmp/file.asm';
  }
}


if(isset($argv[1])) {
  $vmt = new VMTranslator($argv[1]);
  $vmt->translate();
}
