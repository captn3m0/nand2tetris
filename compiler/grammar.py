from keywords import Atom

"""
The grammar is defined by the following constructs:

The top level object is called GRAMMAR, which is the grammar for a class. It is a list object.

Inside this list, each element can be any of the following:

- a token (denoted by a Keyword enum)
- a bitwise mask of the Keyword enum to denote multiple possibilities
- Another list, to denote zero-or-more of a inner-sequence
- A tuple, to denote zero-or-one of a inner-sequence
- A lambda denotes a non-terminal part of the grammar

This is basically an attempt to translate Figure 10.5 from the book into
a Python structure.

"""
class Element:
  def __init__(self, name, grammar, terminal = False):
    self.name = name
    self.grammar = grammar
    self.terminal = terminal

TYPES = Element('type', Atom.INT | Atom.CHAR | Atom.BOOLEAN | Atom.IDENTIFIER, True)

CLASSVARDEC = Element('classVarDec', [
  # static|field type (, name)* ;
  Atom.STATIC | Atom.FIELD,
  TYPES,
  [Atom.COMMA, Atom.IDENTIFIER],
  Atom.SEMICOLON
])

VARDEC = Element('varDec', [Atom.VAR, TYPES, Atom.IDENTIFIER,
  [Atom.COMMA, Atom.IDENTIFIER],
  Atom.SEMICOLON
])
UNARY_OP = Element('unaryOp', Atom.NOT | Atom.MINUS, True)

CONSTANT = Element('KeywordConstant', Atom.TRUE | Atom.FALSE|Atom.NULL|Atom.THIS, True)

TERM = Element('term', Atom.INTEGERCONSTANT | Atom.STRINGCONSTANT | Atom.TRUE | Atom.FALSE | Atom.IDENTIFIER)

OP = Element('op', Atom.PLUS | Atom.MINUS | Atom.MUL | Atom.DIV | Atom.AND | Atom.OR | Atom.GT | Atom.LT | Atom.EQ, True)

EXPRESSION = Element('expression', [TERM, [OP, TERM]])

EXPRESSIONLIST = Element('expressionList', (EXPRESSION, [Atom.COMMA, EXPRESSION]))

SUBROUTINE_CALL = Element('subroutineCall', {
  (Atom.IDENTIFIER, Atom.PARAN_OPEN): [
    EXPRESSIONLIST,
    Atom.PARAN_CLOSE,
  ],
  (Atom.IDENTIFIER, Atom.DOT): [
    Atom.IDENTIFIER,
    Atom.PARAN_OPEN,
    EXPRESSIONLIST,
    Atom.PARAN_CLOSE
  ]
})

STATEMENT = Element('statement', {
  (Atom.LET): [Atom.IDENTIFIER, (Atom.SQUARE_OPEN, EXPRESSION, Atom.SQUARE_CLOSE)],
  (Atom.IF): [
    Atom.PARAN_OPEN,
    EXPRESSION,
    Atom.PARAN_CLOSE,
    Atom.BRACE_OPEN,
    lambda: STATEMENTS,
    Atom.BRACE_CLOSE,
    # This is the tricky one
    ( Atom.ELSE, Atom.BRACE_OPEN, lambda:STATEMENT, Atom.BRACE_CLOSE)
  ],
  (Atom.WHILE): [
    Atom.PARAN_OPEN,
    EXPRESSION,
    Atom.PARAN_CLOSE,
    Atom.BRACE_OPEN,
    lambda: STATEMENTS,
    Atom.BRACE_CLOSE,
  ],
  (Atom.DO): SUBROUTINE_CALL,
  (Atom.RETURN): [(EXPRESSION), Atom.SEMICOLON]
})

STATEMENTS = Element('statements', [STATEMENT])

SUBROUTINE_BODY = Element('subroutineBody', [
  # One or more variable declarations
  # `var type varName (, varName)* ;`
    [VARDEC],
    STATEMENTS
])

""" Pseudo-element to help define subroutine declarations """
RETURN_TYPES= Atom.INT | Atom.CHAR|Atom.BOOLEAN|Atom.IDENTIFIER|Atom.VOID

# Parameter List =
#  (
#    (type varName) (, type varName)*
#  )?
# we use tuples for zero OR one of a sequence
PARAMETER_LIST = Element('parameterList', (
  TYPES,
  Atom.IDENTIFIER,
  [Atom.COMMA, TYPES, Atom.IDENTIFIER]
))

SUBROUTINEDEC = Element('subroutineDec', [
  # (constructor | function | method) (void | type) subRoutineName '(' parameterList ')'
  # subroutineBody
  Atom.CONSTRUCTOR | Atom.FUNCTION | Atom.METHOD,
  RETURN_TYPES,
  Atom.IDENTIFIER,
  Atom.PARAN_OPEN,
  PARAMETER_LIST,
  Atom.PARAN_CLOSE,
  # Subroutine Body {
  Atom.BRACE_OPEN,
  SUBROUTINE_BODY,
  Atom.BRACE_CLOSE,
])

CLASS = Element('class', [
  # class className {
  Atom.CLASS,
  Atom.IDENTIFIER,
  Atom.BRACE_OPEN,
  # class Variable Declarations (one or more) = list
  CLASSVARDEC,
  # subroutine declarations (one or more) = list
  SUBROUTINEDEC,
  # }
  Atom.BRACE_CLOSE
])
