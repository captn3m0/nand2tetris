from tokenizer import JackTokenizer
from keywords import *
from grammar import CLASS

"""
New Compilation Engine
"""
class Engine:
  def __init__(self, input_file):
    self.i = 0
    self.jt = JackTokenizer(input_file, False)
    self.file = open(self.xml_file())

  def xml_file(self, input_file):
    return input_file + ".xml"

  """ Throughout the compilation engine, we work using atoms"""
  def atom(self):
    token = self.jt.tokenType()
    return Atom(token.value)

  def compileClass(self):
    self.compile(grammar.CLASS)

  def advance(self):
    self.jt.advance()

  def ZeroOrMany(self, grammarList):
    if compile(grammarList[0]):
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
    xml_rows_for_lookup_terms = []
    lookup_keys = ()
    # How much to lookahead
    lookahead = len(list(dict.keys())[0])
    for _ in range(lookahead):
      xml_rows_for_lookup_terms += [self.jt.xml_row()]
      lookup_keys = lookup_keys + (self.atom(),)
      self.advance()

    for line in xml_rows_for_lookup_terms:
      self.write(line)

    for e in dict[lookup_keys]:
      self.compile(e)

  def ZeroOrOne(self, grammarTuple):
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
      print(current)
      self.advance()
    else:
      raise Exception("Expected %s, got %s" % (expected, current))

  def compile(self, thing):
    # TODO: OPEN TAGS
    if isinstance(thing, Element):
      print("open %s" % thing.name)
      grammar = thing.grammar
    elif callable(thing):
      grammar = thing()
    else:
      grammar = thing
    grammarType = type(grammar)

    elif grammarType == list:
      return self.ZeroOrMany(thing)
    elif grammarType == dict:
      return self.MatchDict(thing)
    elif grammarType == tuple:
      return self.ZeroOrOne(thing)
    elif grammarType == Atom:
      return self.Atom(thing)
    elif callable(thing):
      return self.compile(thing)

    if isinstance(thing, Element):
      print("close %s" % thing.name)
