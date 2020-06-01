<?php
namespace captn3m0\NandToTetris;

require_once("CommandType.php");
require_once("CodeWriter.php");
require_once("Parser.php");

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

        $this->writer->nextSourceLine();
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
