<?php

namespace captn3m0\NandToTetris;

class CodeWriter {
  function __construct($outputFile) {
    $this->ic = 0;
    $this->sourceLine = 0;
    $this->file = fopen($outputFile, "w");

    // We aren't inside a function by default
    $this->fn = null;

    $this->comments = true;

    // Write the preamble for the assembler
    $this->writeInit();
  }

  private function push($kind, $what, $direct = false) {
    if ($kind === 'register') {
      assert(in_array($what, [
        'SP','LCL','ARG','THIS','THAT',
        'R0','R1','R2','R3','R4','R5',
        'R6','R7','R8','R9','R10','R11'
        ,'R12','R13','R14','R15' , 'D', 'A']
      ));

      switch ($what) {
        // A Can be optimized
        case 'A':
          $direct = true;
          $this->write(['D=A']);
          break;
        case 'D':
          $direct = true;
          break;

        default:
          $this->write([
            "@$what",
            "AD=M",
          ]);
          break;
      }

      if ($direct === false) {
        $this->write(["D=M"]);
      }
    } else if ($kind === 'label') {
      $this->write([
        "@$what",
        "D=A"
      ]);
    }

    $this->writeDtoSPAndBump();
  }

  private function writeDtoSPAndBump() {
    $this->write([
      "@SP",
      "A=M",
      "M=D",
    ]);

    $this->increaseSP();
  }

  private function increaseSP() {
    $this->write([
      "@SP",
      "M=M+1",
    ]);
  }

  public function writeReturn() {
    $this->write([
      '@LCL // save return address first',
      'A=M-1',
      'A=A-1',
      'A=A-1',
      'A=A-1',
      'A=A-1',
      'D=M // D now holds the return address',
      '@R14',
      'M=D // Wrote the return address to R14',

      "@SP // return for {$this->fn} starts",
      'A=M-1',
      'D=M',// Popped value to D
      // And then write it to R14
      '@ARG',
      'A=M',
      'M=D',

      // SP=ARG+1
      '@ARG',
      'D=M+1',
      '@SP',
      'M=D // @SP = ARG+1',
      '@LCL',
      'D=M',
      '@R13',
      'M=D // Save LCL to R13 = FRAME',

      // now we go restoring THAT, THIS, ARG, LCL
      'A=D-1 // A=*LCL-1',
      'D=M // D=*(*LCL-1)',
      '@THAT // A=THAT',
      'M=D   // *that = *(*lcl-1)',

      // now we restore THIS
      '@R13',
      'A=M-1',
      'A=A-1 // A=*LCL-2',
      'D=M // D=*(*LCL-2)',
      '@THIS // A=THIS',
      'M=D   // *THIS = *(*lcl-2)',

      // now we restore ARG
      '@R13',
      'A=M-1',
      'A=A-1',
      'A=A-1 // A=*LCL-3',
      'D=M // D=*(*LCL-3)',
      '@ARG // A=ARG',
      'M=D   // *ARG = *(*lcl-3)',

      // now we restore LCL
      '@R13',
      'A=M-1',
      'A=A-1',
      'A=A-1',
      'A=A-1 // A=*LCL-4',
      'D=M // D=*(*LCL-4)',
      '@LCL // A=LCL',
      'M=D   // *LCL = *(*lcl-4)',

      // Now we hyperjump
      '@R14',
      'A=M',
      '0;JMP // HyperJump to *(LCL-5)',
    ]);
  }

  /**
   * Translates the "function" start.
   * function $name $args
   */
  public function writeFunction($name, $numArgs) {
    // This is used for labels within the current function
    $this->fn = $name;

    $this->write([
      "($name) // function $name $numArgs",
    ]);

    // We write this once at the top
    // And for subsequent loops, we can re-use
    // the @SP call at the end where we bump the stack by 1
    if ($numArgs > 0) {
      $this->write([
        // This is only required for the first argument
        '@SP',
        'A=M',
      ]);
    }

    // For every argument in the function
    // push a zero to the stack
    for($i=0;$i<$numArgs;$i++) {
      $this->write([
        'M=0',
        '@SP',
        'AM=M+1',
      ]);
    }
  }

  private function copy($registerA, $registerB) {
    $this->write([
      "@$registerA",
      'D=M',
      "@$registerB",
      "M=D // Update $registerB=$registerA",
    ]);
  }

  private function loadOffsetToD($register, $offset, $sign = '-') {
    $this->write([
      "@$register",
      "D=M",
    ]);

    for ($i=0; $i < $offset; $i++) {
      $this->write([
        'D=D' . $sign . "1 // should repeat $offset times",
      ]);
    }
  }

  /**
   * Function call executed, save state and JUMP
   */
  public function writeCall(String $functionName, $numArgs) {
    $returnLabel = bin2hex(random_bytes(16));

    $this->push('label', $returnLabel);

    // push the exact values that these registers are holding
    $this->push('register', 'LCL', true);
    $this->push('register', 'ARG', true);
    $this->push('register', 'THIS', true);
    $this->push('register', 'THAT', true);
    $this->copy('SP', 'LCL');

    // Reduce D height times = numArgs+5
    $offset = $numArgs + 5;

    $this->loadOffsetToD('SP', $offset, '-');
    // now D = SP-n-5

    // now we need to write D to ARG
    $this->write([
      '@ARG // write SP-$offset to ARG',
      'M=D',
      "@$functionName // Jump to $functionName",
      '0;JMP',
      "($returnLabel) // return back from function here (CALL ENDS)",
    ]);

    // If we have returned from the Sys.init function call
    // then put an infinite loop here
    if ($functionName === "Sys.init") {
      $this->write([
        '(__GLOBAL_TERMINATE__)',
        '@__GLOBAL_TERMINATE__',
        '0;JMP',
      ]);
    }
  }

  private function writeConstantToRegister(String $register, Int $constant) {
    if ($constant < 0) {
      $constant = abs($constant);
      $this->write([
        "@$constant",
        "D=-A"
      ]);
    } else if ($constant === 0) {
      $this->write(["D=0"]);
    } else {
      $this->write([
        "@$constant",
        "D=A"
      ]);
    }
    $this->write([
      "@$register",
      "M=D // initialized $register to $constant",
    ]);
  }

  /**
   * Writes the preable to initialize the VM
   */
  private function writeInit($initExists = true) {
    $this->writeConstantToRegister("SP", 256);
    $this->writeConstantToRegister("LCL", -1);
    $this->writeConstantToRegister("ARG", -2);
    $this->writeConstantToRegister("THIS", -3);
    $this->writeConstantToRegister("THAT", -4);

    $this->writeCall('Sys.init', 0);
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
      '0;JMP',
    ]);
  }

  /**
   * Writes label X as (fnlabel)
   */
  function writeLabel(String $label) {
    $globalLabel = $this->resolveLabel($label);
    $this->write([
      "($globalLabel) // end label $label",
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
      "0;JMP // end goto $label",
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
      "D;JNE // end if-goto $label",
    ]);
  }

  private function binaryMath(String $command) {
    $map = [
      'sub' => '-',
      'add' => '+',
      'and' => '&',
      'or'  => '|'
    ];

    $symbol = $map[$command];

    $this->write([
      'A=A-1',
      "M=D{$symbol}M",
    ]);

    if ($command === 'sub') {
      $this->write([
        'M=-M'
      ]);
    }
  }

  private function unaryMath(String $command) {
    $symbol = [
      'neg' => '-',
      'not' => '!'
    ][$command];

    $this->write([
      "M={$symbol}M // end $command",
    ]);
  }

  private function booleanCompare(String $compare) {
    $compare = strtoupper($compare);
    $command = "D;J$compare";

    $jumpPointer = $this->ic+10;
    $this->write([
      'A=A-1',
      'D=M-D',
      'M=0',
      'M=M-1',
      "@$jumpPointer",
      $command,
      '@SP',
      'A=M-1',
      'A=A-1',
      'M=0',
    ]);
  }

  function writeArithmetic(String $command) {
    $stackDecrease=true;
    // Read top of stack to D
    $this->write([
      "@SP // ==== $command ====",
      'A=M-1',
      'D=M'
    ]);

    switch ($command) {
      // TODO: Combine all the binary math commands into one
      // And the unary math commands into one
      case 'sub':
      case 'add':
      case 'and':
      case 'or':
        $this->binaryMath($command);
        break;

      case 'neg':
      case 'not':
        $this->unaryMath($command);
        $stackDecrease = false;
        break;

      // TODO: Combine all the boolean commands
      case 'lt':
      case 'gt':
      case 'eq':
        $this->booleanCompare($command);
        break;

      default:
        throw new \Exception("$command not Implemented", 1);
    }

    if ($stackDecrease) {
      $this->write([
        '@SP',
        "M=M-1 // end $command"
      ]);
    }
  }

  private function write(Array $lines) {
    // print_r(debug_backtrace());
    // exit(1);
    $callingLine = debug_backtrace()[0]['line'];
    $callingFunction = debug_backtrace(DEBUG_BACKTRACE_IGNORE_ARGS)[1]['function'];
    $args = join(", ", debug_backtrace(false, 2)[1]['args']);
    foreach ($lines as $line) {
      if ($this->comments === true ) {
        $line = "$line \t\t\t\t// (L{$this->sourceLine}:{$this->ic}) ($callingFunction($args):$callingLine)\n";
      } else {
        $line = "$line\n";
      }
      fwrite($this->file, $line);
      if (substr($line, 0, 2) !== "//" and substr($line, 0, 1) !== "(") {
        $this->ic += 1;
      }
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
          'D=A',
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
          'A=M',
          'D=M',
        ]);
        break;

      case 'static':
        $symbol = $this->resolveStatic($index);
        $this->write([
          $symbol,
          'D=M'
        ]);
        break;

      case 'pointer':
        $register = $this->resolvePointer($index);
        $this->write([
          "$register // pointer $index",
          'D=M'
        ]);
        break;

      case 'temp':
        $register = $this->resolveTemp($index);
        $this->write([
          "$register // temp $index",
          'D=M'
        ]);
        break;

      default:
        throw new \Exception("Not Implemented $segment", 1);
        break;
    }

    $this->writeDtoSPAndBump();
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
        'D=M',
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
          'D=M',
          $lookupRegister,
          "A=M // Read $lookupRegister to A (for $segment $index)",
          "M=D // end pop $segment $index",
        ]);
        break;

      case 'static':
        $symbol = $this->resolveStatic($index);
        $this->write([
          "@SP //pop $segment $index",
          "AM=M-1",
          'D=M',
          $symbol,
          "M=D // end pop $segment $index"
        ]);
        break;

      case 'pointer':
        // pointer points to a 2 register segment holding [this, that]
        $register = $this->resolvePointer($index);
        $this->write([
          "@SP // pop",
          "AM=M-1",
          'D=M',
          $register,
          "M=D //"
        ]);
        break;

      case 'temp':
        $tempRegister = $this->resolveTemp($index);
        $this->write([
          "@SP",
          "AM=M-1",
          'D=M',
          "$tempRegister",
          "M=D // end pop temp $index"
        ]);
        break;

      default:
        throw new \Exception("Not implemented pop $segment");
        break;
    }
  }

  /**
   * Resolves pointer [0|1] to the this|that register
   */
  private function resolvePointer(Int $index) {
    return ($index === 0) ? '@THIS' : '@THAT';
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
