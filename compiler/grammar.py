from keywords import Keyword

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

TYPES = Element('type', Keyword.INT | Keyword.CHAR | Keyword.BOOLEAN | Keyword.IDENTIFIER, True)

CLASSVARDEC = Element('classVarDec', [
  # static|field type (, name)* ;
  Keyword.STATIC | Keyword.FIELD,
  TYPES,
  [Keyword.COMMA, Keyword.IDENTIFIER],
  Keyword.SEMICOLON
])

VARDEC = Element('varDec', [Keyword.VAR, TYPES, Keyword.IDENTIFIER,
  [Keyword.COMMA, Keyword.IDENTIFIER],
  Keyword.SEMICOLON
])
UNARY_OP = Element('unaryOp', Keyword.NOT | Keyword.MINUS, True)

CONSTANT = Element('KeywordConstant', Keyword.TRUE | Keyword.FALSE|Keyword.NULL|Keyword.THIS, True)

TERM = Element('term', Keyword.INTEGERCONSTANT | Keyword.STRINGCONSTANT | Keyword.TRUE | Keyword.FALSE | Keyword.IDENTIFIER)

OP = Element('op', Keyword.PLUS | Keyword.MINUS | Keyword.MUL | Keyword.DIV | Keyword.AND | Keyword.OR | Keyword.GT | Keyword.LT | Keyword.EQ, True)

EXPRESSION = Element('expression', [TERM, [OP, TERM]])

EXPRESSIONLIST = Element('expressionList', (EXPRESSION, [Keyword.COMMA, EXPRESSION]))

SUBROUTINE_CALL = Element('subroutineCall', {
  (Keyword.IDENTIFIER, Keyword.PARAN_OPEN): [
    EXPRESSIONLIST,
    Keyword.PARAN_CLOSE,
  ],
  (Keyword.IDENTIFIER, Keyword.DOT): [
    Keyword.IDENTIFIER,
    Keyword.PARAN_OPEN,
    EXPRESSIONLIST,
    Keyword.PARAN_CLOSE
  ]
})

STATEMENT = Element('statement', {
  (Keyword.LET): [Keyword.IDENTIFIER, (Keyword.SQUARE_OPEN, EXPRESSION, Keyword.SQUARE_CLOSE)],
  (Keyword.IF): [
    Keyword.PARAN_OPEN,
    EXPRESSION,
    Keyword.PARAN_CLOSE,
    Keyword.BRACE_OPEN,
    lambda: STATEMENTS,
    Keyword.BRACE_CLOSE,
    # This is the tricky one
    ( Keyword.ELSE, Keyword.BRACE_OPEN, lambda:STATEMENT, Keyword.BRACE_CLOSE)
  ],
  (Keyword.WHILE): [
    Keyword.PARAN_OPEN,
    EXPRESSION,
    Keyword.PARAN_CLOSE,
    Keyword.BRACE_OPEN,
    lambda: STATEMENTS,
    Keyword.BRACE_CLOSE,
  ],
  (Keyword.DO): SUBROUTINE_CALL,
  (Keyword.RETURN): [(EXPRESSION), Keyword.SEMICOLON]
})

STATEMENTS = Element('statements', [STATEMENT])

SUBROUTINE_BODY = Element('subroutineBody', [
  # One or more variable declarations
  # `var type varName (, varName)* ;`
    [VARDEC],
    STATEMENTS
])

""" Pseudo-element to help define subroutine declarations """
RETURN_TYPES= Keyword.INT | Keyword.CHAR|Keyword.BOOLEAN|Keyword.IDENTIFIER|Keyword.VOID

# Parameter List =
#  (
#    (type varName) (, type varName)*
#  )?
# we use tuples for zero OR one of a sequence
PARAMETER_LIST = Element('parameterList', (
  TYPES,
  Keyword.IDENTIFIER,
  [Keyword.COMMA, TYPES, Keyword.IDENTIFIER]
))

SUBROUTINEDEC = Element('subroutineDec', [
  # (constructor | function | method) (void | type) subRoutineName '(' parameterList ')'
  # subroutineBody
  Keyword.CONSTRUCTOR | Keyword.FUNCTION | Keyword.METHOD,
  RETURN_TYPES,
  Keyword.IDENTIFIER,
  Keyword.PARAN_OPEN,
  PARAMETER_LIST,
  Keyword.PARAN_CLOSE,
  # Subroutine Body {
  Keyword.BRACE_OPEN,
  SUBROUTINE_BODY,
  Keyword.BRACE_CLOSE,
])

CLASS = Element('class', [
  # class className {
  Keyword.CLASS,
  Keyword.IDENTIFIER,
  Keyword.BRACE_OPEN,
  # class Variable Declarations (one or more) = list
  CLASSVARDEC,
  # subroutine declarations (one or more) = list
  SUBROUTINEDEC,
  # }
  Keyword.BRACE_CLOSE
])
