from enum import IntFlag,auto

""" Super class for everything """
class Atom(IntFlag):
  # Keywords
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

class Keyword(IntFlag):
  CLASS = Atom.CLASS.value
  METHOD = Atom.METHOD.value
  FUNCTION = Atom.FUNCTION.value
  CONSTRUCTOR = Atom.CONSTRUCTOR.value
  INT = Atom.INT.value
  BOOLEAN = Atom.BOOLEAN.value
  CHAR = Atom.CHAR.value
  VOID = Atom.VOID.value
  VAR = Atom.VAR.value
  STATIC = Atom.STATIC.value
  FIELD = Atom.FIELD.value
  LET = Atom.LET.value
  DO = Atom.DO.value
  IF = Atom.IF.value
  ELSE = Atom.ELSE.value
  WHILE = Atom.WHILE.value
  RETURN = Atom.RETURN.value
  TRUE = Atom.TRUE.value
  FALSE = Atom.FALSE.value
  NULL = Atom.NULL.value
  THIS = Atom.THIS.value

class Symbol(IntFlag):
  # Symbols Start here
  BRACE_OPEN = Atom.BRACE_OPEN.value
  BRACE_CLOSE = Atom.BRACE_CLOSE.value
  PARAN_OPEN = Atom.PARAN_OPEN.value
  PARAN_CLOSE = Atom.PARAN_CLOSE.value
  SQUARE_OPEN = Atom.SQUARE_OPEN.value
  SQUARE_CLOSE = Atom.SQUARE_CLOSE.value
  DOT = Atom.DOT.value
  SEMICOLON = Atom.SEMICOLON.value
  PLUS = Atom.PLUS.value
  MINUS = Atom.MINUS.value
  MUL = Atom.MUL.value
  DIV = Atom.DIV.value
  AND = Atom.AND.value
  OR = Atom.OR.value
  LT = Atom.LT.value
  GT = Atom.GT.value
  EQ = Atom.EQ.value
  NOT = Atom.NOT.value
  COMMA = Atom.COMMA.value

class Token(IntFlag):
  IDENTIFIER = Atom.IDENTIFIER.value
  INTEGERCONSTANT = Atom.INTEGERCONSTANT.value
  STRINGCONSTANT = Atom.STRINGCONSTANT.value
  SYMBOL = auto()
  KEYWORD = auto()
