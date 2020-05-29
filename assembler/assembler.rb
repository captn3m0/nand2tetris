# frozen_string_literal: true

fn = ARGV[0]
ic = 0

class Code
  DEST_MAP = {
    'null' => [0, 0, 0],
    'M' => [0, 0, 1],
    'D' => [0, 1, 0],
    'MD' => [0, 1, 1],
    'A' => [1, 0, 0],
    'AM' => [1, 0, 1],
    'AD' => [1, 1, 0],
    'AMD' => [1, 1, 1]
  }.freeze

  JUMP_MAP = {
    'null' => [0, 0, 0],
    'JGT' => [0, 0, 1],
    'JEQ' => [0, 1, 0],
    'JGE' => [0, 1, 1],
    'JLT' => [1, 0, 0],
    'JNE' => [1, 0, 1],
    'JLE' => [1, 1, 0],
    'JMP' => [1, 1, 1]
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

  def dest; end

  def comp; end

  def jump; end

  def run
    advance while more_commands?
  end

  def initialize(_file_name)
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
