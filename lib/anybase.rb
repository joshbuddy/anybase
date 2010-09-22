require 'anybase/version'

class Anybase

  UnrecognizedCharacterError = Class.new(RuntimeError)

  attr_reader :chars, :char_map, :num_map

  def initialize(chars, opts = nil)
    @chars = chars
    @ignore_case = opts && opts.key?(:ignore_case) ? opts[:ignore_case] : false
    @sign = opts && opts.key?(:sign) ? opts[:sign] : nil
    raise if @sign && @chars.index(@sign)
    @synonyms = opts && opts[:synonyms]
    @synonyms_tr = ['', ''] if @synonyms
    @char_map = Hash.new{|h,k| raise UnrecognizedCharacterError.new("the character `#{k.chr}' is not included in #{@chars}")}
    @num_map = {}
    if ignore_case?
      @chars.downcase!
    end
    @chars.split('').each_with_index do |c, i|
      add_mapping(c, i)
      @num_map[i] = c
      if @synonyms && @synonyms[c]
        @synonyms[c].split('').each { |sc| 
          @synonyms_tr[1] << c
          @synonyms_tr[0] << sc
        }
      end
    end
  end

  def ignore_case?
    @ignore_case
  end
  
  def size(digits)
    chars.length ** digits
  end
  
  def normalize(val)
    val = val.downcase if ignore_case?
    @synonyms ? val.tr(*@synonyms_tr) : val
  end

  def random(digits, opts = nil)
    zero_pad = opts && opts.key?(:zero_pad) ? opts[:zero_pad] : true
    number = ''
    digits.times { number << chars[rand(chars.size)]}
    unless zero_pad
      number.sub!(/\A#{Regexp.quote(chars[0].chr)}+/, '')
      number = chars[0].chr if number.empty?
    end
    number
  end
  
  def to_i(val)
    val = normalize(val)
    op = if @sign and val[0] == @sign[0]
      val.slice!(0, 1)
      :-
    else
      :+
    end
    num = 0
    (0...val.size).each{|i|
      num = num.send(op, (chars.size ** (val.size - i - 1)) * char_map[val[i]])
    }
    num
  end

  def to_native(val, options = nil)
    if val < 0
      if @sign
        val = val.abs
        signed = true
      else
        raise
      end
    end
    str = ''
    until val.zero?
      digit = val % chars.size
      val /= chars.size
      str[0, 0] = num_map[digit]
    end
    if options && options[:zero_pad] && (options[:zero_pad] - str.size) > 0
      str[0, 0] = num_map[0] * (options[:zero_pad] - str.size)
    end
    str == '' ? num_map[0].dup : (signed ? @sign.dup << str : str)
  end

  def add_mapping(c, i)
    char_map[c[0]] = i
  end
  private :add_mapping

  Hex          = Anybase.new('0123456789abcdef', :ignore_case => true)
  Base62       = Anybase.new('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789')
  Base64       = Anybase.new('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/')
  Base64ForURL = Anybase.new('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_')
  Base73ForURL = Anybase.new('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$-_.+!*\'(),')

end
