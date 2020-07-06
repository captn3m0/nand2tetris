from keywords import Atom

"""
The grammar is defined by the following constructs:

The top level object is called GRAMMAR, which is the grammar for a class.
It is a instance of the Element class
The element class contains a grammar element, which is always defined as a list
for an element class.

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
  # Usually I avoid inverted boolean variable names, but this is much cleaner
  def __init__(self, name, grammar):
    assert(type(grammar)==list)
    self.name = name
    self.grammar = grammar
    self.empty = False

  def __repr__(self):
    return self.name

CLASSVARDEC = Element('classVarDec', [
  # static|field type (, name)* ;
  Atom.STATIC | Atom.FIELD,
  Atom.INT | Atom.CHAR | Atom.BOOLEAN | Atom.IDENTIFIER,
  Atom.IDENTIFIER,
  [Atom.COMMA, Atom.IDENTIFIER],
  Atom.SEMICOLON
])

VARDEC = Element('varDec', [Atom.VAR, Atom.INT | Atom.CHAR | Atom.BOOLEAN | Atom.IDENTIFIER, Atom.IDENTIFIER,
  [Atom.COMMA, Atom.IDENTIFIER],
  Atom.SEMICOLON
])

# Since this is not a non-terminal, we can just write it as a constant
OP = Atom.PLUS | Atom.MINUS | Atom.MUL | Atom.DIV | Atom.AND | Atom.OR | Atom.GT | Atom.LT | Atom.EQ
UNARY_OP = Atom.NOT | Atom.MINUS
CONSTANT = Atom.TRUE | Atom.FALSE|Atom.NULL|Atom.THIS
""" Pseudo-element to help define subroutine declarations """
RETURN_TYPES= Atom.INT | Atom.CHAR|Atom.BOOLEAN|Atom.IDENTIFIER|Atom.VOID

# TODO: This is missing the following:
# var [expression]
# subRoutineCall
# (expressions in parenthes)
# unaryOP TERM
TERM = Element('term', [
  Atom.INTEGERCONSTANT | Atom.STRINGCONSTANT | Atom.TRUE | Atom.FALSE | Atom.NULL| Atom.THIS | Atom.IDENTIFIER
])

EXPRESSION = Element('expression', [TERM, [OP, TERM]])

EXPRESSIONLIST = Element('expressionList', [(EXPRESSION, [Atom.COMMA, EXPRESSION])])

DO_STATEMENT = Element('doStatement', [{
  (Atom.IDENTIFIER, Atom.PAREN_OPEN): [
    EXPRESSIONLIST,
    Atom.PAREN_CLOSE,
  ],
  (Atom.IDENTIFIER, Atom.DOT): [
    Atom.IDENTIFIER,
    Atom.PAREN_OPEN,
    EXPRESSIONLIST,
    Atom.PAREN_CLOSE
  ]
},Atom.SEMICOLON])

LET_STATEMENT = Element('letStatement', [
  Atom.IDENTIFIER,
  (Atom.SQUARE_OPEN, EXPRESSION, Atom.SQUARE_CLOSE),
  Atom.EQ,
  EXPRESSION,
  Atom.SEMICOLON
])

IF_STATEMENT = Element('ifStatement', [
  Atom.PAREN_OPEN,
  EXPRESSION,
  Atom.PAREN_CLOSE,
  Atom.BRACE_OPEN,
  lambda: STATEMENTS,
  Atom.BRACE_CLOSE,
  # This is the tricky one
  ( Atom.ELSE, Atom.BRACE_OPEN, lambda:STATEMENTS, Atom.BRACE_CLOSE)
])

WHILE_STATEMENT = Element('whileStatement', [
  Atom.PAREN_OPEN,
  EXPRESSION,
  Atom.PAREN_CLOSE,
  Atom.BRACE_OPEN,
  lambda: STATEMENTS,
  Atom.BRACE_CLOSE,
])

RETURN_STATEMENT = Element('returnStatement', [(EXPRESSION), Atom.SEMICOLON])

# Just a constant, since this isn't a non-terminal
STATEMENT = {
  (Atom.LET,): LET_STATEMENT,
  (Atom.IF,): IF_STATEMENT,
  (Atom.WHILE,): WHILE_STATEMENT,
  (Atom.DO,): DO_STATEMENT,
  (Atom.RETURN,): RETURN_STATEMENT
}

STATEMENTS = Element('statements', [[STATEMENT]])

SUBROUTINE_BODY = Element('subroutineBody', [
  # One or more variable declarations
  # `var type varName (, varName)* ;`
  Atom.BRACE_OPEN,
  [VARDEC],
  STATEMENTS,
  Atom.BRACE_CLOSE
])

# Parameter List =
#  (
#    (type varName) (, type varName)*
#  )?
# we use tuples for zero OR one of a sequence
PARAMETER_LIST = Element('parameterList', [(
  Atom.INT | Atom.CHAR | Atom.BOOLEAN | Atom.IDENTIFIER,
  Atom.IDENTIFIER,
  [Atom.COMMA, Atom.INT | Atom.CHAR|Atom.BOOLEAN|Atom.IDENTIFIER, Atom.IDENTIFIER]
)])

EXPRESSIONLIST.empty = PARAMETER_LIST.empty = True

SUBROUTINEDEC = Element('subroutineDec', [
  # (constructor | function | method) (void | type) subRoutineName '(' parameterList ')'
  # subroutineBody
  Atom.CONSTRUCTOR | Atom.FUNCTION | Atom.METHOD,
  RETURN_TYPES,
  Atom.IDENTIFIER,
  Atom.PAREN_OPEN,
  PARAMETER_LIST,
  Atom.PAREN_CLOSE,
  SUBROUTINE_BODY,
])

CLASS = Element('class', [
  Atom.CLASS,
  Atom.IDENTIFIER,
  Atom.BRACE_OPEN,
  [CLASSVARDEC],
  [SUBROUTINEDEC],
  Atom.BRACE_CLOSE
])
