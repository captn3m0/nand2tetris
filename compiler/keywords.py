from enum import Enum,Flag,auto

class Keyword(Flag):
  CLASS = auto()
  METHOD = auto()
  FUNCTION = auto()
  CONSTRUCTOR = auto()
  INT = auto()
  BOOLEAN = auto()
  CHAR = auto()
  VOID = auto()
  VAR = auto()
  STATIC = auto()
  FIELD = auto()
  LET = auto()
  DO = auto()
  IF = auto()
  ELSE = auto()
  WHILE = auto()
  RETURN = auto()
  TRUE = auto()
  FALSE = auto()
  NULL = auto()
  THIS = auto()
  # Symbols Start here
  BRACE_OPEN = auto()
  BRACE_CLOSE = auto()
  PARAN_OPEN = auto()
  PARAN_CLOSE = auto()
  SQUARE_OPEN = auto()
  SQUARE_CLOSE = auto()
  DOT = auto()
  SEMICOLON = auto()
  PLUS = auto()
  MINUS = auto()
  MUL = auto()
  DIV = auto()
  AND = auto()
  OR = auto()
  LT = auto()
  GT = auto()
  EQ = auto()
  NOT = auto()
  COMMA = auto()
  # Other Tokens
  IDENTIFIER = auto()
  INTEGERCONSTANT = auto()
  STRINGCONSTANT = auto()

class Symbol(Flag):
    # Symbols Start here
    BRACE_OPEN = Keyword.BRACE_OPEN
    BRACE_CLOSE = Keyword.BRACE_CLOSE
    PARAN_OPEN = Keyword.PARAN_OPEN
    PARAN_CLOSE = Keyword.PARAN_CLOSE
    SQUARE_OPEN = Keyword.SQUARE_OPEN
    SQUARE_CLOSE = Keyword.SQUARE_CLOSE
    DOT = Keyword.DOT
    SEMICOLON = Keyword.SEMICOLON
    PLUS = Keyword.PLUS
    MINUS = Keyword.MINUS
    MUL = Keyword.MUL
    DIV = Keyword.DIV
    AND = Keyword.AND
    OR = Keyword.OR
    LT = Keyword.LT
    GT = Keyword.GT
    EQ = Keyword.EQ
    NOT = Keyword.NOT
    COMMA = Keyword.COMMA

class Token(Flag):
    KEYWORD = auto()
    SYMBOL = auto()
    IDENTIFIER = Keyword.IDENTIFIER
    INTEGERCONSTANT = Keyword.INTEGERCONSTANT
    STRINGCONSTANT = Keyword.STRINGCONSTANT
