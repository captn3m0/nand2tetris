# frozen_string_literal: true

fn = ARGV[0]

# Not implemented yet
class SymbolTable
end

class Code
  DEST_MAP = {
    nil => "000",
    'M' => "001",
    'D' => "010",
    'MD' => "011",
    'A' => "100",
    'AM' => "101",
    'AD' => "110",
    'AMD' => "111"
  }.freeze

  JUMP_MAP = {
    nil => "000",
    'JGT' => "001",
    'JEQ' => "010",
    'JGE' => "011",
    'JLT' => "100",
    'JNE' => "101",
    'JLE' => "110",
    'JMP' => "111"
  }.freeze
  COMP_MAP = {
    '0' => '101010',
    '1' => '111111',
    '-1' => '111010',
    'D' => '001100',
    'Y' => '110000',
    '!D' => '001101',
    '!Y' => '110001',
    '-D' => '001111',
    '-Y' => '110011',
    'D+1' => '011111',
    'Y+1' => '110111',
    'D-1' => '001110',
    'Y-1' => '110010',
    'D+Y' => '000010',
    'D-Y' => '010011',
    'Y-D' => '000111',
    'D&Y' => '000000',
    'D|Y' => '010101'
  }.freeze
  def self.dest(str)
    Code::DEST_MAP[str]
  end

  def self.jump(str)
    Code::JUMP_MAP[str]
  end

  def self.comp(str)
    a = c1 = c2 = c3 = c4 = c5 = c6 = 0
    a = str.include? 'M'
    key = str.gsub(/[AM]/, 'Y')
    (a ? '1' : '0') + COMP_MAP[key]
  end
end

class Parser
  def more_commands?
    @ic < @lines.size
  end

  def advance
    @ic += 1
  end

  def line
    @lines[@ic]
  end

  def command_type
    case line[0]
    when '@'
      :A_COMMAND
    when '('
      :L_COMMAND
    else
      :C_COMMAND
    end
  end

  def symbol
    case command_type
    when :A_COMMAND
      line[1..-1]
    when :L_COMMAND
      line[1..-2]
    end
  end

  def dest
    return nil unless line.include? '='
    line.split('=').first
  end

  def comp
    if dest && jump
      line.split('=').last.split(';').first
    elsif dest
      line.split('=').last
    elsif jump
      line.split(';').first
    else
      line
    end
  end

  def jump
    return nil unless line.include? ';'
    line.split(';').last
  end
  def run
    res = []
    while more_commands?
      case command_type
      when :A_COMMAND
        res << [command_type, [symbol]]
      when :C_COMMAND
        res << [command_type, [dest, comp, jump]]
      when :L_COMMAND
        res << [command_type, [symbol]]
      end
      advance
    end
    res
  end

  def initialize(fn)
    @ic = 0
    @lines = []
    File.readlines(fn).each do |line|
      line.chomp!
      next if line.empty?
      next if line[0...2] == '//'

      @lines << line
    end
  end
end

class Assembler
  attr_reader :res
  def initialize(fn)
    @res = []
    parser = Parser.new(fn)
    parser.run.each do |command|
      instruction = command[0]
      case instruction
      when :A_COMMAND
        symbol = command[1][0]
        @res << symbol.to_i.to_s(2).rjust(16, "0")
      when :C_COMMAND
        dest,comp,jump = command[1]
        @res << "111#{Code.comp(comp)}#{Code.dest(dest)}#{Code.jump(jump)}"
      end
    end
  end
end

if ARGV[0]
  asm = Assembler.new(fn)
  puts asm.res.join("\n")
end
