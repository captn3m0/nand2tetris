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

class Sequence(list):
  def first(self):
    return self[0]

class Element:
  # Usually I avoid inverted boolean variable names, but this is much cleaner
  def __init__(self, name, grammar):
    # Since Any derives from list, this ought to work
    assert(isinstance(grammar, list) or isinstance(grammar, dict))
    self.name = name
    self.grammar = grammar
    self.empty = False

  def first(self):
    if isinstance(self.grammar, list):
      return self.grammar[0]
    elif isinstance(self.grammar, dict):
      return list(self.grammar.keys())[0]

  def __repr__(self):
    return self.name

CLASSVARDEC = Element('classVarDec', Sequence([
  # static|field type (, name)* ;
  Atom.STATIC | Atom.FIELD,
  Atom.INT | Atom.CHAR | Atom.BOOLEAN | Atom.IDENTIFIER,
  Atom.IDENTIFIER,
  # Zero or one of these
  [Atom.COMMA, Atom.IDENTIFIER],
  Atom.SEMICOLON
]))

VARDEC = Element('varDec', Sequence([
  Atom.VAR, Atom.INT | Atom.CHAR | Atom.BOOLEAN | Atom.IDENTIFIER, Atom.IDENTIFIER,
  # Zero or one of these
  [Atom.COMMA, Atom.IDENTIFIER],
  Atom.SEMICOLON
]))

# Since these are not a non-terminal, we can just write it as a constant
OP = Atom.PLUS | Atom.MINUS | Atom.MUL | Atom.DIV | Atom.AND | Atom.OR | Atom.GT | Atom.LT | Atom.EQ
UNARY_OP = Atom.NOT | Atom.MINUS
CONSTANT = Atom.TRUE | Atom.FALSE | Atom.NULL | Atom.THIS
""" Pseudo-element to help define subroutine declarations """
RETURN_TYPES= Atom.INT | Atom.CHAR | Atom.BOOLEAN | Atom.IDENTIFIER | Atom.VOID

# This is a flattened version of the Term structure
TERM = Element('term', {
  (Atom.INTEGERCONSTANT,): None,
  (Atom.STRINGCONSTANT,): None,
  (Atom.TRUE,): None,
  (Atom.FALSE,): None,
  (Atom.NULL,): None,
  (Atom.THIS,): None,
  # unaryOp TERM
  (Atom.NOT,): Sequence([lambda: TERM]),
  (Atom.MINUS,): Sequence([lambda: TERM]),
  # (expression)
  (Atom.PAREN_OPEN,): Sequence([lambda: EXPRESSION, Atom.PAREN_CLOSE]),
  (Atom.IDENTIFIER,): {
    # array lookup
    (Atom.SQUARE_OPEN,): Sequence([lambda: EXPRESSION, Atom.SQUARE_CLOSE]),
    # Subroutine call, but with class name
    (Atom.DOT,): Sequence([
      Atom.IDENTIFIER,
      Atom.PAREN_OPEN,
      lambda: EXPRESSIONLIST,
      Atom.PAREN_CLOSE
    ]),
    # Subroutine call, but to same class
    (Atom.PAREN_OPEN,): Sequence([
      lambda: EXPRESSIONLIST,
      Atom.PAREN_CLOSE
    ])
  }
})

EXPRESSION = Element('expression', Sequence([TERM, [OP, TERM]]))

EXPRESSIONLIST = Element('expressionList', Sequence([
  (EXPRESSION, [Atom.COMMA, EXPRESSION])
]))

SUBROUTINE_CALL = [
  (Atom.IDENTIFIER, Atom.DOT),
  Atom.IDENTIFIER,
  Atom.PAREN_OPEN,
  EXPRESSIONLIST,
  Atom.PAREN_CLOSE
]

DO_STATEMENT = Element('doStatement', Sequence([SUBROUTINE_CALL,Atom.SEMICOLON]))

LET_STATEMENT = Element('letStatement', Sequence([
  Atom.IDENTIFIER,
  (Atom.SQUARE_OPEN, EXPRESSION, Atom.SQUARE_CLOSE),
  Atom.EQ,
  EXPRESSION,
  Atom.SEMICOLON
]))

IF_STATEMENT = Element('ifStatement', Sequence([
  Atom.PAREN_OPEN,
  EXPRESSION,
  Atom.PAREN_CLOSE,
  Atom.BRACE_OPEN,
  lambda: STATEMENTS,
  Atom.BRACE_CLOSE,
  # This is the tricky one
  ( Atom.ELSE, Atom.BRACE_OPEN, lambda:STATEMENTS, Atom.BRACE_CLOSE)
]))

WHILE_STATEMENT = Element('whileStatement', Sequence([
  Atom.PAREN_OPEN,
  EXPRESSION,
  Atom.PAREN_CLOSE,
  Atom.BRACE_OPEN,
  lambda: STATEMENTS,
  Atom.BRACE_CLOSE,
]))

RETURN_STATEMENT = Element('returnStatement', Sequence([
  (EXPRESSION), Atom.SEMICOLON
]))

# Just a constant, since this isn't a non-terminal
STATEMENT = {
  (Atom.LET,): LET_STATEMENT,
  (Atom.IF,): IF_STATEMENT,
  (Atom.WHILE,): WHILE_STATEMENT,
  (Atom.DO,): DO_STATEMENT,
  (Atom.RETURN,): RETURN_STATEMENT
}

STATEMENTS = Element('statements', Sequence([[STATEMENT]]))

SUBROUTINE_BODY = Element('subroutineBody', Sequence([
  # One or more variable declarations
  # `var type varName (, varName)* ;`
  Atom.BRACE_OPEN,
  [VARDEC],
  STATEMENTS,
  Atom.BRACE_CLOSE
]))

# Parameter List =
#  (
#    (type varName) (, type varName)*
#  )?
# we use tuples for zero OR one of a sequence
PARAMETER_LIST = Element('parameterList', Sequence([(
  Atom.INT | Atom.CHAR | Atom.BOOLEAN | Atom.IDENTIFIER,
  Atom.IDENTIFIER,
  # Zero or one of the following:
  [Atom.COMMA, Atom.INT | Atom.CHAR|Atom.BOOLEAN|Atom.IDENTIFIER, Atom.IDENTIFIER]
)]))

EXPRESSIONLIST.empty = PARAMETER_LIST.empty = True

SUBROUTINEDEC = Element('subroutineDec', Sequence([
  # (constructor | function | method) (void | type) subRoutineName '(' parameterList ')'
  # subroutineBody
  Atom.CONSTRUCTOR | Atom.FUNCTION | Atom.METHOD,
  RETURN_TYPES,
  Atom.IDENTIFIER,
  Atom.PAREN_OPEN,
  PARAMETER_LIST,
  Atom.PAREN_CLOSE,
  SUBROUTINE_BODY,
]))

CLASS = Element('class', Sequence([
  Atom.CLASS,
  Atom.IDENTIFIER,
  Atom.BRACE_OPEN,
  [CLASSVARDEC],
  [SUBROUTINEDEC],
  Atom.BRACE_CLOSE
]))
