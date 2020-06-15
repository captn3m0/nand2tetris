from enum import Enum
import re
import sys
from html import escape

class Token(Enum):
  KEYWORD = 1
  SYMBOL = 2
  IDENTIFIER = 3
  INTEGERCONSTANT = 4
  STRINGCONSTANT = 5
  UNKNOWN = 6

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

  """ Returns the type of the current token """
  def tokenType(self):
    t = self.current_token()
    if t in ['class','constructor','function','method','field','static','var','int','char','boolean','void','true','false','null','this','let','do','if','else','while','return']:
      return Token.KEYWORD
    elif re.compile("(\(|\)|\[|\]|,|\+|-|;|<|>|=|~|&|{|}|\*|\/|\||\.)").match(t):
      return Token.SYMBOL
    elif re.compile("\d+").match(t):
      return Token.INTEGERCONSTANT
    elif re.compile("\".*\"").match(t):
      return Token.STRINGCONSTANT
    else:
      return Token.IDENTIFIER
    pass

  def printable_token(self):
    if self.tokenType() == Token.STRINGCONSTANT:
      return self.current_token()[1:-1]
    else:
      return escape(self.current_token(), True)

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
    if self.tokenType() != Token.INTEGERCONSTANT:
      raise RuntimeError("Should only be called when tokenType is INTEGERCONSTANT")
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
      # Regex contains 3 parts:
      # 1. Keywords
      # 2. Symbols
      # 3. Identifiers
      regex = re.compile("(class|constructor|function|method|field|static|var|int|char|boolean|void|true|false|null|this|let|do|if|else|while|return|\(|\)|\[|\]|,|\+|-|;|<|>|=|~|&|{|}|\*|\/|\||\.|[a-zA-Z_]+\w*|\".*\")")
      return [e.strip() for e in regex.split(line) if e != None and e.strip()!='']

  def has_more_tokens(self):
    return self.ptr < len(self.tokens)

  def current_token(self):
    return self.tokens[self.ptr]

  def advance(self):
    self.ptr += 1

  def __init__(self, filename, print_xml=False):
    self.ptr = 0
    self.insideMultiLineComment = False
    self.file = open(filename, 'r')
    self.tokens = []
    for line in self.file:
      self.tokens += self.parse_line(line)

    if(print_xml):
      self.print_xml(self.xml_file(filename))

  def xml_file(self, jack_file):
    return jack_file + "T.xml"

  def print_xml(self, xml_filename):
    with open(xml_filename, 'w') as f:
      f.write("<tokens>\n")
      while self.has_more_tokens():
        f.write("<{type}> {value} </{type}>\n".format(type=self.tokenType().name.lower(), value=self.printable_token()))
        self.advance()
      f.write("</tokens>\n")

class CompilationEngine:
  def __init__(self):
    pass

if __name__ == '__main__':
  jt = JackTokenizer(sys.argv[1], True)

