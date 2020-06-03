<?php

namespace captn3m0\NandToTetris;

class CodeWriter {
  function __construct($outputFile) {
    $this->ic = 0;
    $this->sourceLine = 0;
    $this->file = fopen($outputFile, "w");

    // We aren't inside a function by default
    $this->fn = null;
  }

  public function writeReturn() {
    $this->write([
      "@SP",
      "A=M-1",
      "D=M",// Popped value to D
      // And then write it to *ARG = pop()
      "@ARG",
      "A=M",
      "M=D",

      // SP=ARG+1
      "@ARG",
      "D=M+1",
      "@SP",
      "M=D // @SP = ARG+1",
      "@LCL",
      "D=M",
      "@R13",
      "M=D // Save LCL to R13",

      // now we go restoring THAT, THIS, ARG, LCL
      "A=D-1 // A=*LCL-1",
      "D=M // D=*(*LCL-1)",
      "@THAT // A=THAT",
      "M=D   // *that = *(*lcl-1)",
      // now we restore THIS
      "@R13",
      "A=M-1",
      "A=A-1 // A=*LCL-2",
      "D=M // D=*(*LCL-2)",
      "@THIS // A=THIS",
      "M=D   // *THIS = *(*lcl-2)",

      // now we restore ARG
      "@R13",
      "A=M-1",
      "A=A-1",
      "A=A-1 // A=*LCL-3",
      "D=M // D=*(*LCL-3)",
      "@ARG // A=ARG",
      "M=D   // *ARG = *(*lcl-3)",

      // now we restore LCL
      "@R13",
      "A=M-1",
      "A=A-1",
      "A=A-1",
      "A=A-1 // A=*LCL-4",
      "D=M // D=*(*LCL-4)",
      "@LCL // A=LCL",
      "M=D   // *LCL = *(*lcl-4)",

      // Now we hyperjump
      "@R13",
      "A=M-1",
      "A=A-1",
      "A=A-1",
      "A=A-1",
      "A=A-1 // A=*LCL-5",
      "A=M  // A=*(*LCL-5)",
      "0;JMP // Jump to *(LCL-5)",
    ]);
  }

  public function writeFunction($name, $numArgs) {
    $this->fn = $name;
    $this->write([
      "($name) // function $name $numArgs",
    ]);
    for($i=0;$i<$numArgs;$i++) {
      $this->write([
        "@SP",
        "A=M",
        "M=D",
        "@SP",
        "M=M+1"
      ]);
    }
  }

  /**
   * Writes the preable to initialize the VM
   */
  private function writeInit() {
    $this->write([
      "@256",
      "D=A",
      "@SP",
      "M=D // initialized SP to 256",
      "@16000",
      "D=A",
      "@LCL",
      "M=D // initialized @LCL to 16000",
      "@16500",
      "D=A",
      "@ARG",
      "M=D // initialized @ARG to 16500",
    ]);
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

  /**
   * Puts the closing non-terminating
   * loop
   */
  function close() {
    $endJump = $this->ic+1;
    $this->write([
      "@$endJump",
      "0;JMP"
    ]);
  }

  /**
   * Writes label X as (fnlabel)
   */
  function writeLabel(String $label) {
    $globalLabel = $this->resolveLabel($label);
    $this->write([
      "($globalLabel) // end label $label (L{$this->sourceLine})",
    ]);
  }

  /**
   * Generates a unique global label
   * by using the current function name
   */
  private function resolveLabel(String $label) {
    if($this->fn === null)
      return "__GLOBAL__.$label";
    return $this->fn . $label;
  }

  /**
   * Writes a unconditional jump statement
   */
  public function writeGoto(String $label) {
    $globalLabel = $this->resolveLabel($label);
    $this->write([
      "@$globalLabel",
      "0;JMP // end goto $label (L{$this->sourceLine})",
    ]);
  }

  /**
   * Writes corresponding code for if-goto
   * if value == true, goto X
   * else keep executing
   */
  function writeIf(String $label) {
    $globalLabel = $this->resolveLabel($label);
    $this->write([
      // Read top of the stack to D
      '@SP',
      'AM=M-1',
      'D=M',
      "@$globalLabel",
      "D;JNE // end if-goto $label (L{$this->sourceLine})",
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
        $register = $this->resolveSegmentToRegister($segment);
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

  /**
   * Resolves a given segment to a register
   */
  private function resolveSegmentToRegister(String $segment) {
    return [
      'local' => '@LCL',
      'argument' => '@ARG',
      'this' => '@THIS',
      'that' => '@THAT',
    ][$segment];
  }

  /**
   * For cases where we need calculations on both LHS and RHS, we temporarily
   * store the resolved address of the memory segment to R13. This is the code
   * that does that
   */
  private function resolveSegmentToR13(string $segment, Int $index) {
    $register = $this->resolveSegmentToRegister($segment);
    $this->write([
        "$register // $segment $index" ,
        "D=M",
        "@$index // write $index to A",
        "D=D+A // D = segment+index",
        "@R13 // save it to R13",
        "M=D // write $register+$index to R13",
      ]);
  }

  /**
   * Static variables are just the same labels repeated again
   * They are unique across a file
   */
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
          $lookupRegister = $this->resolveSegmentToRegister($segment);
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
