use std::fs::File;
use std::env;
use std::io::{self, BufRead};
use std::path::Path;
fn main() -> std::io::Result<()> {
  let fileName = env::args().nth(1);
  let fileLines = read_lines(fileName);
  Ok(())
}


fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where P: AsRef<Path>, {
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}

