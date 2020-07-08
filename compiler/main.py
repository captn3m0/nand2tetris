from engine import Engine
import sys
from pathlib import Path

if __name__ == '__main__' and len(sys.argv) > 1:
  p = Path(sys.argv[1])
  if p.is_dir():
    for f in p.glob("*.jack"):
      print("compiling %s" % f)
      Engine(f.as_posix()).compileClass()
  elif p.is_file():
    Engine(p.as_posix()).compileClass()