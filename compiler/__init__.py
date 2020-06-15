from enum import Enum
import re

class Token(Enum):
  KEYWORD = 1
  SYMBOL = 2
  IDENTIFIER = 3
  INT_CONST = 4
  STRING_CONST = 5

class Keyword(Enum):
  CLASS = 1
  METHOD = 2
  FUNCTION = 3
  CONSTRUCTOR = 4
  INT = 5
  BOOLEAN = 6
  CHAR = 7
  VOID = 8
  VAR = 9
  STATIC = 10
  FIELD = 11
  LET = 12
  DO = 13
  IF = 14
  ELSE = 15
  WHILE = 16
  RETURN = 17
  TRUE = 18
  FALSE = 19
  NULL = 20
  THIS = 21

class JackAnalyzer:
  def __init__(self):
    pass

class JackTokenizer:

  # KEYWORD_REGEXES='(class|constructor|function|method|field|static|var|int|char|boolean|void|true|false|null|this|let|do|if|else|while|return)'

  # SYMBOL_REGEXES = [
  #   "{","}","\(","\)","]","["
  # ]

  """ Returns the type of the current token """
  def tokenType(self):
    pass

  """ Returns the character which is the current token """
  def symbol(self):
    if self.tokenType() != Token.SYMBOL:
      raise RuntimeError("Should only be called when tokenType is SYMBOL")

  """ Returns the identifier which is the current token """
  def identifier(self):
    if self.tokenType() != Token.IDENTIFIER:
      raise RuntimeError("Should only be called when tokenType is IDENTIFIER")

  """ Returns the integer value of the current token """
  def intVal(self):
    if self.tokenType() != Token.INT_CONST:
      raise RuntimeError("Should only be called when tokenType is INT_CONST")
    return int(self.token)

  """ Returns a list of tokens for that line """
  def parse_line(self, line):
    line = line.strip()
    # If this line as a single line comment anywhere
    # strip the line to start of //
    if line.find("//") != -1:
      # print("Starting single line comment on %s" % line)
      line = line[:line.find("//")].strip()

    if self.insideMultiLineComment:
      if line.find("*/") == -1:
        # print("Still inside multi line comment, continuing %s" % line)
        # The comment doesn't end in this line
        return []
      else:
        # print("Closing multi line comment, continuing %s" % line)
        self.insideMultiLineComment = False
        # comments ends here, huzzah!
        line = line[:line.find("*/")].strip()

    # Same for the multi-line comment, but this time
    # Also set insideMultiLineComment = true
    elif line.find("/*") != -1:
      # The comment ends on the same line
      if line.find("*/") != -1:
        # TODO: This doesn't handle multiple multi-line comments on the same line
        # TODO: this also breaks on /* inside strings :(
        line = line[:line.find("/*")] + line[line.find("*/") + 2:].strip()
        # print("This line has a /* and */ %s" % line)
        # print("This line has a /* and */ %s" % len(line))
      else:
        # print("Starting multi line comment on %s" % line)
        line = line[:line.find("/*")].strip()
        self.insideMultiLineComment = True

    # We don't need no empty lines
    if len(line) == 0:
      return []
    else:
      regex = re.compile("(class|constructor|function|method|field|static|var|int|char|boolean|void|true|false|null|this|let|do|if|else|while|return)|(\(|\)|\[|\]|,|\+|-|;|<|>|=|~|&|{|}|\*|\/|\|)")
      tokens = regex.split(line)
      return [e.strip() for e in tokens if e != None and e.strip()!='']

  def advance(self):
    self.tokens = []
    for line in self.file:
      self.tokens += self.parse_line(line)

    print(self.tokens)

  def __init__(self, filename):
    self.insideMultiLineComment = False
    self.file = open(filename, 'r')

class CompilationEngine:
  def __init__(self):
    pass

if __name__ == '__main__':
  jt = JackTokenizer("../projects/10/Square/Square.jack")
  jt.advance()
