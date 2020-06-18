from keywords import Keyword

"""
The grammar is defined by the following constructs:

The top level object is called GRAMMAR, which is the grammar for a class. It is a list object.

Inside this list, each element can be any of the following:

- a token (denoted by a Keyword enum)
- a bitwise mask of the Keyword enum to denote multiple possibilities
- Another list, to denote zero-or-more of a inner-sequence
- A tuple, to denote zero-or-one of a inner-sequence

This is basically an attempt to translate Figure 10.5 from the book into
a Python structure.

"""

TYPE = Keyword.INT | Keyword.CHAR | Keyword.BOOLEAN | Keyword.IDENTIFIER

UNARY_OP = Keyword.NOT | Keyword.MINUS

TERM = Keyword.INTEGERCONSTANT | Keyword.STRINGCONSTANT | Keyword.TRUE | Keyword.FALSE | Keyword.IDENTIFIER

OP = Keyword.PLUS | Keyword.MINUS | Keyword.MUL | Keyword.DIV | Keyword.AND | Keyword.OR | Keyword.GT | Keyword.LT | Keyword.EQ

EXPRESSION = [TERM, [OP, TERM]]

EXPRESSIONLIST = (EXPRESSION, [Keyword.COMMA, EXPRESSION])

SUBROUTINE_CALL = {
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
}

STATEMENTS = {
  (Keyword.LET): [Keyword.IDENTIFIER, (Keyword.SQUARE_OPEN, EXPRESSION, Keyword.SQUARE_CLOSE)],
  (Keyword.IF): [
    Keyword.PARAN_OPEN,
    EXPRESSION,
    Keyword.PARAN_CLOSE,
    Keyword.BRACE_OPEN,
    lambda:STATEMENTS,
    Keyword.BRACE_CLOSE,
    ( Keyword.ELSE, Keyword.BRACE_OPEN, lambda:STATEMENTS, Keyword.BRACE_CLOSE)
  ],
  (Keyword.WHILE): [
    Keyword.PARAN_OPEN,
    EXPRESSION,
    Keyword.PARAN_CLOSE,
    Keyword.BRACE_OPEN,
    lambda:STATEMENTS,
    Keyword.BRACE_CLOSE,
  ],
  (Keyword.DO): SUBROUTINE_CALL,
  (Keyword.RETURN): [(EXPRESSION), Keyword.SEMICOLON]
}

SUBROUTINEDEC = [
  # (constructor | function | method) (void | type) subRoutineName '(' parameterList ')'
  # subroutineBody
  Keyword.CONSTRUCTOR | Keyword.FUNCTION | Keyword.METHOD,
  Keyword.VOID | TYPE,
  Keyword.IDENTIFIER,
  Keyword.PARAN_OPEN,
  # Parameter List =
  #  (
  #    (type varName) (, type varName)*
  #  )?
  # we use tuples for zero OR one of a sequence
  (
    TYPE,
    Keyword.IDENTIFIER,
    [Keyword.COMMA, TYPE, Keyword.IDENTIFIER]
  ),
  Keyword.PARAN_CLOSE,
  # Subroutine Body {
  Keyword.BRACE_OPEN,
  # One or more variable declarations
  # `var type varName (, varName)* ;`
  [
    Keyword.VAR,
    TYPE,
    Keyword.IDENTIFIER,
    [Keyword.COMMA, Keyword.IDENTIFIER],
    Keyword.SEMICOLON
  ],
  STATEMENTS,
  Keyword.BRACE_CLOSE,
]

CLASSVARDEC = [
  # static|field type (, name)* ;
  Keyword.STATIC | Keyword.FIELD,
  TYPE,
  [Keyword.COMMA, Keyword.IDENTIFIER],
  Keyword.SEMICOLON
]

GRAMMAR = [
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
]
