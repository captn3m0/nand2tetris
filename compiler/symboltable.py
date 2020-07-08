from constants import SymbolType

class SymbolTable:
  def __init__(self):
    self.subroutineTable = {}
    self.classTable = {}
    self.subroutineIndex = 0
    self.classIndex = 0

  def startSubroutine(self):
    self.subroutineTable = {}

  def define(self, name, var_type, kind):
    if (kind in [SymbolType.STATIC, SymbolType.FIELD]):
      self.classTable[name] = (var_type, kind, self.classIndex)
      self.classIndex += 1
    elif (kind in [SymbolType.ARG, SymbolType.VAR]):
      self.subroutineTable[name] = (var_type, kind, self.subroutineIndex)
      self.subroutineIndex += 1
    else:
      raise Exception("Invalid SymbolType")

  def varCount(self, kind):
    t = None
    if (kind in [SymbolType.STATIC, SymbolType.FIELD]):
      t = self.classTable
    elif (kind in [SymbolType.ARG, SymbolType.VAR]):
      t = self.subroutineTable
    else:
      raise Exception("Invalid SymbolType")
    return len([i for i in t.values() if i[1] == kind])

  def _lookup(self, name, index):
    if name in self.classTable:
      return self.classTable[name][index]
    elif name in self.subroutineTable:
      return self.subroutineTable[name][index]
    else:
      raise Exception("Invalid variable name")

  def TypeOf(self, name):
    return self._lookup(name, 0)

  def KindOf(self, name):
    return self._lookup(name, 1)

  def IndexOf(self, name):
    return self._lookup(name, 2)
