from grammar import GRAMMAR

class CompilationEngine:
  def xml_file(self, input_file):
    return input_file + ".xml"

  """ Calling keyword does an implicit assert """
  def k(self):
    assert(self.jt.tokenType() == Token.KEYWORD)
    return CompilationEngine.KEYWORD_MAP[self.jt.current_token()]

  def v(self):
    assert(self.type() == Token.SYMBOL or self.type() == Token.IDENTIFIER)
    return self.jt.current_token()

  """ Opens one of the heirarchial tags """
  def open(self, tag):
    self.file.write((self.i * " ") + "<%s>" % tag)
    self.i+=2

  """ Closes a tag """
  def close(self, tag):
    self.file.write((self.i * " ") + "<%s>" % tag)
    self.i-=2

  """ Advances the Tokenizer and prints a debug statement"""
  def advance(self):
    old = self.jt.current_token()
    self.jt.advance()
    print("Advanced from {old} to {t} {new}".format(t=self.type(),old=old, new=self.jt.current_token()))

  def type(self):
    return self.jt.tokenType()

  def s(self):
    return CompilationEngine.SYMBOL_MAP[self.jt.symbol()]

  def CompileClass(self):
    self.open("class")
    self.do_the_thing(Keyword.CLASS, Token.IDENTIFIER, Symbol.BRACE_OPEN)
    while(not (self.type() == Token.SYMBOL and self.v() == '}' )):
      if (self.k() in [Keyword.STATIC, Keyword.FIELD]):
        self.CompileClassVarDec()
      elif(self.k() in [Keyword.CONSTRUCTOR, Keyword.FUNCTION, Keyword.METHOD]):
        self.CompuleSubroutine()
      else:
        raise RuntimeError("Invalid Token")
    assert(self.type() == Token.SYMBOL and self.v() == '}')
    self.close("class")

  def we_need_a_type(self):
    if (self.type() == Token.Keyword):
      self.do_the_thing(Keyword.INT | Keyword.CHAR | Keyword.BOOLEAN)
    else:
      self.do_the_thing(Token.IDENTIFIER)

  def CompileClassVarDec(self):
    self.open('classVarDec')
    self.do_the_thing(Keyword.STATIC | Keyword.FIELD)
    self.we_need_a_type()
    self.do_the_thing(Token.IDENTIFIER, [SYMBOL.PARAN_OPEN, Token.IDENTIFIER])
    self.close('classVarDec')
    self.advance()


  """ Writes a single line(with \n) on the XML, taking into account the indentation """
  def write(self, klass, subklass = None):
    print(self.type())
    print(klass)
    assert(klass == self.type())
    if (klass == Token.SYMBOL):
      assert(subklass == self.s())
    elif(klass == Token.KEYWORD):
      assert(subklass & self.k())
    elif(subklass == Token.INTEGERCONSTANT):
      self.jt.intVal()
    self.file.write((self.i * " ") + self.jt.xml_row())

  def matches(self, T):
    return (isinstance(T, Symbol) and T == self.s()) or (isinstance(T, Keyword) and T & self.k()) or T==Token.INTEGERCONSTANT or T==Token.STRINGCONSTANT

  def do_the_thing(self,*args):
    for T in args:
      # We use a list for *, which is zero or more times
      if isinstance(T, list):
        # LL(0) for now
        if
      if isinstance(T, Symbol):
        self.write(Token.SYMBOL, T)
      elif isinstance(T, Keyword):
        self.write(Token.KEYWORD, T)
      else:
        assert(self.type() in [Token.IDENTIFIER, Token.INTEGERCONSTANT, Token.STRINGCONSTANT])
        self.write(T)
      self.advance()

  def CompuleSubroutine(self):
    self.open('subroutineDec')
    self.write()
    pass
  def CompuleParameterList(self):
    pass
  def CompileVarDec(self):
    pass
  def CompileStatements(self):
    pass
  def CompileDo(self):
    pass
  def CompileLet(self):
    pass
  def CompileWhile(self):
    pass
  def CompileReturn(self):
    pass
  def CompileIf(self):
    pass
  def CompileTerm(self):
    pass

  def __init__(self, input_file):
    self.i = 0
    self.jt = JackTokenizer(input_file, False)
    self.file = open(self.xml_file(input_file), 'w')
