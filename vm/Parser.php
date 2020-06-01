<?php

namespace captn3m0\NandToTetris;

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
