import re
from constants import *
from html import escape
from enum import Enum
# Superclass in some sense
class JackTokenizer:
  SYMBOL_MAP = {
    '{': Symbol.BRACE_OPEN ,
    '}': Symbol.BRACE_CLOSE ,
    '(': Symbol.PAREN_OPEN ,
    ')': Symbol.PAREN_CLOSE ,
    '[': Symbol.SQUARE_OPEN ,
    ']': Symbol.SQUARE_CLOSE ,
    '.': Symbol.DOT ,
    ';': Symbol.SEMICOLON ,
    '+': Symbol.PLUS ,
    '-': Symbol.MINUS ,
    '*': Symbol.MUL ,
    '/': Symbol.DIV ,
    '&': Symbol.AND ,
    '|': Symbol.OR ,
    '<': Symbol.LT ,
    '>': Symbol.GT ,
    '=': Symbol.EQ ,
    '~': Symbol.NOT ,
    ',': Symbol.COMMA,
  }

  KEYWORD_MAP = {
    "class": Keyword.CLASS,
    "method": Keyword.METHOD,
    "function": Keyword.FUNCTION,
    "constructor": Keyword.CONSTRUCTOR,
    "int": Keyword.INT,
    "boolean": Keyword.BOOLEAN,
    "char": Keyword.CHAR,
    "void": Keyword.VOID,
    "var": Keyword.VAR,
    "static": Keyword.STATIC,
    "field": Keyword.FIELD,
    "let": Keyword.LET,
    "do": Keyword.DO,
    "if": Keyword.IF,
    "else": Keyword.ELSE,
    "while": Keyword.WHILE,
    "return": Keyword.RETURN,
    "true": Keyword.TRUE,
    "false": Keyword.FALSE,
    "null": Keyword.NULL,
    "this"    : Keyword.THIS
  }
  """ Returns the type of the current token """
  def tokenType(self):
    t = self.current_token()
    if t in ['class','constructor','function','method','field','static','var','int','char','boolean','void','true','false','null','this','let','do','if','else','while','return']:
      return JackTokenizer.KEYWORD_MAP[t]
    elif re.compile("(\(|\)|\[|\]|,|\+|-|;|<|>|=|~|&|{|}|\*|\/|\||\.)").match(t):
      return JackTokenizer.SYMBOL_MAP[t]
    elif re.compile("\d+").match(t):
      return Token.INTEGERCONSTANT
    elif re.compile("\".*\"").match(t):
      return Token.STRINGCONSTANT
    else:
      # TODO: Put an assert to ensure valid identifier
      return Token.IDENTIFIER
    pass

  def printable_token(self):
    if self.tokenType() == Token.STRINGCONSTANT:
      return self.current_token()[1:-1]
    else:
      return escape(self.current_token(), True)

  def assert_type(self, t):
    if(t == Token.SYMBOL):
      assert(self.tokenType() in SYMBOL_MAP.values())
    elif(t == Token.KEYWORD):
      assert(self.tokenType() in KEYWORD_MAP.values())
    else:
      assert(self.tokenType() == t)

  """ Returns the character which is the current token """
  def symbol(self):
    self.assert_type(Token.SYMBOL)
    return self.current_token()

  """ Returns the identifier which is the current token """
  def identifier(self):
    self.assert_type(Token.IDENTIFIER)
    return self.current_token()

  """ Returns the integer value of the current token """
  def intVal(self):
    self.assert_type(Token.INTEGERCONSTANT)
    return int(self.token)

  """ Returns a list of tokens for that line """
  def parse_line(self, line):
    line = line.strip()
    # If this line as a single line comment anywhere
    # strip the line to start of //
    if line.find("//") != -1:
      line = line[:line.find("//")].strip()

    if self.insideMultiLineComment:
      if line.find("*/") == -1:
        # The comment doesn't end in this line
        return []
      else:
        self.insideMultiLineComment = False
        # comments ends here, huzzah!
        line = line[:line.find("*/")].strip()

    # Same for the multi-line comment, but this time
    # Also set insideMultiLineComment = true
    elif line.find("/*") != -1:
      # The comment ends on the same line
      if line.find("*/") != -1:
        # TODO: this also breaks on /* inside strings :(
        # TODO: This also breaks on multiple multi-line comments on the same line
        line = line[:line.find("/*")] + line[line.find("*/") + 2:].strip()
      else:
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
      # 4. Strings
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

  """ Returns a single row of XML for the Compilation Engine """
  def xml_row(self):
    t = self.tokenType()
    if t in JackTokenizer.SYMBOL_MAP.values():
      t = 'symbol'
    elif t in JackTokenizer.KEYWORD_MAP.values():
      t = 'keyword'
    else:
      t = t.name.lower()
    return "<{type}> {value} </{type}>\n".format(type=t, value=self.printable_token())

  def print_xml(self, xml_filename):
    with open(xml_filename, 'w') as f:
      f.write("<tokens>\n")
      while self.has_more_tokens():
        f.write(self.xml_row())
        self.advance()
      f.write("</tokens>\n")
