# frozen_string_literal: true

fn = ARGV[0]

# Not implemented yet
class SymbolTable
  def initialize
    @st = {:SP => 0,
      :LCL => 1,
      :ARG => 2,
      :THIS => 3,
      :THAT => 4,
      :R0 => 0,
      :R1 => 1,
      :R2 => 2,
      :R3 => 3,
      :R4 => 4,
      :R5 => 5,
      :R6 => 6,
      :R7 => 7,
      :R8 => 8,
      :R9 => 9,
      :R10 => 10,
      :R11 => 11,
      :R12 => 12,
      :R13 => 13,
      :R14 => 14,
      :R15 => 15,
      :SCREEN => 16384,
      :KBD => 24576
    }

  end

  def add(symb, address)
    @st[symb.to_sym] = address
  end

  def has?(symb)
    @st.has_key? symb.to_sym
  end

  def get(symb)
    @st[symb.to_sym]
  end
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
    str.strip!
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

  # Return
  def symbol_type
    symbol[0].match(/^\d/) ? :number : :variable
  end

  def reset
    @ic = 0
  end

  def run
    res = []
    while more_commands?
      case command_type
      when :A_COMMAND
        res << [command_type, [symbol_type, symbol]]
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
      line.strip!
      next if line.empty?
      next if line[0...2] == '//'

      if line.include? '//'
        comment_start = line.index('//')
        line = line[0...comment_start]
        line.strip!
      end

      @lines << line
    end
  end
end

class Assembler
  attr_reader :res
  def initialize(fn)
    @res = []
    @st = SymbolTable.new
    parser = Parser.new(fn)
    # instruction counter for first pass
    ic = 0
    # initial memory pointer starts just after R15
    memory_pointer = 16
    # First pass
    parser.run.each do |command|
      # Our parser has already dropped all comments and whitespace
      # so everything in this pass is either a A or a C instruction
      if command[0] == :L_COMMAND
        symbol = command[1][0]
        @st.add(symbol, ic)
      else
        ic+=1
      end
    end
    # we rewind our parser
    parser.reset
    parser.run.each do |command|
      instruction = command[0]
      case instruction
      when :A_COMMAND
        val = nil
        symbol_type, symbol = command[1]
        if symbol_type === :variable
          if @st.has? symbol
            val =@st.get(symbol)
          else
            val = memory_pointer
            @st.add(symbol, memory_pointer)
            memory_pointer+=1
          end
        else
          val = symbol.to_i
        end
        @res << val.to_i.to_s(2).rjust(16, "0")
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
