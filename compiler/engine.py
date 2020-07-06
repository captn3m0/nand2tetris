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
    self.file = open(input_file + ".xml", 'w')

  def xml_file(self, input_file):
    return input_file + ".xml"

  """ Throughout the compilation engine, we work using atoms"""
  def atom(self):
    token = self.jt.tokenType()
    return Atom(token.value)

