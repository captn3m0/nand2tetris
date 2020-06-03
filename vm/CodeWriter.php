<?php

namespace captn3m0\NandToTetris;

class CodeWriter {
  function __construct($outputFile) {
    $this->ic = 0;
    $this->sourceLine = 0;
    $this->file = fopen($outputFile, "w");
  }

  function setInputFileName($inputFileName) {
    $this->vm = basename($inputFileName, ".vm");
  }

  function nextSourceLine() {
    $this->sourceLine += 1;
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

  function writeArithmetic(String $command) {
    $stackDecrease=true;
    // Read top of stack to D
    $this->write([
      "@SP // ==== $command ====",
      "A=M-1",
      "D=M"
    ]);

    switch ($command) {
      // TODO: Combine all the binary math commands into one
      // And the unary math commands into one
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
          "M=-M // end $command (L{$this->sourceLine})",
        ]);
        $stackDecrease = false;
        break;


      case 'not':
        $this->write([
          "M=!M // end $command (L{$this->sourceLine})",
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

      // TODO: Combine all the boolean commands
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
        "M=M-1 // end $command (L{$this->sourceLine})"
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

  private function resolveTemp(Int $index) {
    // Temp section starts from R5;
    $tempBase = 5;
    $ramAddress = $tempBase + $index;
    return "@R$ramAddress";
  }

  function writePush(String $segment, Int $index) {
    switch ($segment) {
      case 'constant':
        $this->write([
          // Take the constant
          "@$index // push $segment $index",
          // Write it to D
          "D=A",
        ]);
        break;
      case 'argument':
      case 'local':
      case 'this':
      case 'that':
        $register = $this->segmentToRegister($segment);
        if ($index !== 0) {
          $this->resolveSegmentToR13($segment, $index);
          $register = "@R13";
        }
        $this->write([
          $register,
          "A=M",
          "D=M",
        ]);
        break;

      case 'static':
        $symbol = $this->resolveStatic($index);
        $this->write([
          $symbol,
          "D=M"
        ]);
        break;

      case 'pointer':
        $register = $this->resolvePointer($index);
        $this->write([
          "$register // pointer $index",
          "D=M"
        ]);
        break;

      case 'temp':
        $register = $this->resolveTemp($index);
        $this->write([
          "$register // temp $index",
          "D=M"
        ]);
        break;

      default:
        throw new \Exception("Not Implemented $segment", 1);
        break;
    }

    $this->write([
      // A=SP
      "@SP",
      "A=M",
      // Write D to SP
      "M=D",
      // Bump Stack Pointer
      "@SP",
      "M=M+1 // end push $segment $index (L{$this->sourceLine})",
    ]);
  }

  private function segmentToRegister(String $segment) {
    return [
      'local' => '@LCL',
      'argument' => '@ARG',
      'this' => '@THIS',
      'that' => '@THAT',
    ][$segment];
  }

  private function resolveSegmentToR13(string $segment, Int $index) {
    $register = $this->segmentToRegister($segment);
    $this->write([
        "$register // $segment $index" ,
        "D=M",
        "@$index // write $index to A",
        "D=D+A // D = segment+index",
        "@R13 // save it to R13",
        "M=D // write $register+$index to R13",
      ]);
  }

  private function resolveStatic(Int $index) {
    return "@{$this->vm}.$index";
  }

  private function writePop(String $segment, Int $index) {
    switch ($segment) {
      // The address is given by LCL+INDEX
      case 'local':
      case 'argument':
      case 'this':
      case 'that':
        if($index !== 0) {
          $this->resolveSegmentToR13($segment, $index);
          $lookupRegister = '@R13';
        } else{
          $lookupRegister = $this->segmentToRegister($segment);
        }

        $this->write([
          "@SP // pop",
          "AM=M-1",
          "D=M",
          $lookupRegister,
          "A=M // Read $lookupRegister to A (for $segment $index)",
          "M=D // end pop $segment $index (L{$this->sourceLine})",
        ]);
        break;

      case 'static':
        $symbol = $this->resolveStatic($index);
        $this->write([
          "@SP //pop $segment $index",
          "AM=M-1",
          "D=M",
          $symbol,
          "M=D // end pop $segment $index (L{$this->sourceLine})"
        ]);
        break;

      case 'pointer':
        // pointer points to a 2 register segment holding [this, that]
        $register = $this->resolvePointer($index);
        $this->write([
          "@SP // pop",
          "AM=M-1",
          "D=M",
          $register,
          "M=D // (L{$this->sourceLine})"
        ]);
        break;

      case 'temp':
        $tempRegister = $this->resolveTemp($index);
        $this->write([
          "@SP",
          "AM=M-1",
          "D=M",
          "$tempRegister",
          "M=D // end pop temp $index (L{$this->sourceLine})"
        ]);
        break;
      default:
        throw new \Exception("Not implemented pop $segment");
        break;
    }
  }

  private function resolvePointer(Int $index) {
    return $index == 0 ? '@THIS' : '@THAT';
  }

  // Keeping this because book asked me to
  function writePushPop(Int $command, String $segment , Int $index) {
    switch ($command) {
      case CommandType::PUSH:
        $this->writePush($segment, $index);
        break;

      case CommandType::POP:
        $this->writePop($segment, $index);
        break;
      default:
        throw new Exception("Invalid Command Type", 1);
        break;
    }
  }
}
