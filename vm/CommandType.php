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
      $map = [
        "call",
        "push",
        "pop",
        "label",
        "goto",
        "if",
        "func",
        "return"
      ];
      return array_search($name, $map);
    }
  }
}
