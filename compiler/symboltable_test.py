from symboltable import SymbolTable
from constants import SymbolType
def test_st_init():
  st = SymbolTable()
  assert(st.subroutineTable == {})
  assert(st.classTable == {})

def test_st_define():
  st = SymbolTable()
  st.define("first", "int", SymbolType.STATIC)
  st.define("second", "SomeClass", SymbolType.FIELD)
  st.define("third", "String", SymbolType.ARG)
  st.define("fourth", "bool", SymbolType.VAR)

  assert(st.classTable == {
    "first": ("int", SymbolType.STATIC, 0),
    "second": ("SomeClass", SymbolType.FIELD, 1),
  })

  assert(st.subroutineTable == {
    "third": ("String", SymbolType.ARG, 0),
    "fourth": ("bool", SymbolType.VAR, 1),
  })

def test_subroutine():
  st = SymbolTable()
  st.define("first", "int", SymbolType.ARG)
  st.startSubroutine()
  assert(st.subroutineTable == {})

def test_var_count():
  st = SymbolTable()
  st.define("first", "int", SymbolType.STATIC)
  st.define("second", "SomeClass", SymbolType.FIELD)
  st.define("third", "String", SymbolType.ARG)
  st.define("fourth", "bool", SymbolType.VAR)

  assert(st.varCount(SymbolType.STATIC) == 1)
  assert(st.varCount(SymbolType.FIELD) == 1)
  assert(st.varCount(SymbolType.ARG) == 1)
  assert(st.varCount(SymbolType.VAR) == 1)

def test_lookups():
  st = SymbolTable()
  st.define("first", "int", SymbolType.STATIC)
  st.define("second", "SomeClass", SymbolType.FIELD)
  st.define("third", "String", SymbolType.ARG)
  st.define("fourth", "bool", SymbolType.VAR)

  assert(st.KindOf("first") == SymbolType.STATIC)
  assert(st.TypeOf("second") == "SomeClass")
  assert(st.IndexOf("third") == 0)
  assert(st.IndexOf("fourth") == 1)