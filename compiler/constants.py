from enum import IntFlag,auto,Enum

class PrintableFlag(IntFlag):
  def __repr__(self):
    if self.name:
      return self.name
    return super().__str__()

""" Super class for everything """
class Atom(PrintableFlag):
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
  PAREN_OPEN = auto()
  PAREN_CLOSE = auto()
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

class Keyword(PrintableFlag):
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

class Symbol(PrintableFlag):
  # Symbols Start here
  BRACE_OPEN = Atom.BRACE_OPEN.value
  BRACE_CLOSE = Atom.BRACE_CLOSE.value
  PAREN_OPEN = Atom.PAREN_OPEN.value
  PAREN_CLOSE = Atom.PAREN_CLOSE.value
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

class Token(PrintableFlag):
  IDENTIFIER = Atom.IDENTIFIER.value
  INTEGERCONSTANT = Atom.INTEGERCONSTANT.value
  STRINGCONSTANT = Atom.STRINGCONSTANT.value
  SYMBOL = auto()
  KEYWORD = auto()

class SymbolType(Enum):
  STATIC = auto()
  FIELD = auto()
  ARG = auto()
  VAR = auto()