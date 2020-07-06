from tokenizer import JackTokenizer
from keywords import *
from grammar import CLASS,Element

"""
New Compilation Engine
"""
class Engine:
  def __init__(self, input_file):
    self.i = 0
    self.jt = JackTokenizer(input_file, False)
    # self.file = open(self.xml_file(input_file))

  def xml_file(self, input_file):
    return input_file + ".xml"

  """ Throughout the compilation engine, we work using atoms"""
  def atom(self):
    token = self.jt.tokenType()
    return Atom(token.value)

  def compileClass(self):
    self.compile(CLASS)

  def advance(self):
    self.jt.advance()

  def ZeroOrMany(self, grammarList):
    # print("ZeroOrMany")
    if self.compile(grammarList[0]):
      # We now expect the whole of it
      for e in grammarList:
        self.compile(e)
      # We try for another list after this
      return self.ZeroOrMany(grammarList)
    else:
      return None

  def write(self, line):
    print(line)

  def MatchDict(self, dictionary):
    # print("MatchDict")
    xml_rows_for_lookup_terms = []
    lookup_keys = ()
    # How much to lookahead
    lookahead = len(list(dictionary.keys())[0])
    for _ in range(lookahead):
      xml_rows_for_lookup_terms += [self.jt.xml_row()]
      lookup_keys = lookup_keys + (self.atom(),)
      self.advance()

    grammar = dict[lookup_keys]

    # We must open this before we compile the remainder
    if isinstance(grammar, Element):
      self.open(grammar)
      grammar = grammar.grammar

    # Now we put the first X terms from the conditional
    for line in xml_rows_for_lookup_terms:
      self.write(line)

    return self.compile(grammar)

  def ZeroOrOne(self, grammarTuple):
    # print("ZeroOrOne")
    if self.compile(grammarTuple[0]):
      for e in grammarTuple:
        self.compile(e)
      return True
    else:
      return None

  """ Has to MATCH """
  def Atom(self, atom):
    expected = atom
    current = self.atom()
    # We use in here to accomodate for bitmasks
    if current in expected:
      print(self.jt.xml_row(), end="")
      self.advance()
      return True
    else:
      return False

  def open(self, el):
    print("<%s>" % el.name)

  def close(self, el):
    print("</%s>" % el.name)

  def compile(self, thing):
    # TODO: OPEN TAGS
    if isinstance(thing, Element):
      self.open(thing)
      for e in thing.grammar:
        self.compile(e)
      self.close(thing)
    elif callable(thing):
      grammar = thing()
      self.compile(grammar)
    else:
      grammar = thing
      grammarType = type(grammar)

      if grammarType == list:
        return self.ZeroOrMany(grammar)
      elif grammarType == dict:
        return self.MatchDict(grammar)
      elif grammarType == tuple:
        return self.ZeroOrOne(grammar)
      elif grammarType == Atom:
        return self.Atom(grammar)
      else:
        raise Exception("Should not have reached here")
