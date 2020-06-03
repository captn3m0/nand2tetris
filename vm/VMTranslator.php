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

  /**
   * This is the main entry point for the VM Translator
   * and starts the translate sequence
   */
  function translate() {
    foreach ($this->files as $file) {

      $parser = new Parser($file);
      $this->writer->setInputFileName($file);

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

          case CommandType::LABEL:
            $label = $parser->arg1();
            $this->writer->writeLabel($label);
            break;

          case CommandType::IF:
            $label = $parser->arg1();
            $this->writer->writeIf($label);
            break;

          case CommandType::GOTO:
            $label = $parser->arg1();
            $this->writer->writeGoto($label);
            break;

          case CommandType::FUNC:
            $functionName = $parser->arg1();
            $numberOfArgs = $parser->arg2();
            $this->writer->writeFunction($functionName, $numberOfArgs);
            break;

          case CommandType::RETURN:
            $this->writer->writeReturn();
            break;

          case CommandType::CALL:
            $functionName = $parser->arg1();
            $numberOfArgs = $parser->arg2();
            $this->writer->writeCall($functionName, $numberOfArgs);
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

  /**
   * Generates an output file name
   * for the VM. Same as the Directory.asm
   */
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
