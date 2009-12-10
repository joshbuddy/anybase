class Anybase

  attr_reader :chars
  
  UnrecognizedCharacterError = Class.new(RuntimeError)
  
  def initialize(chars, opts = nil)
    @chars = chars
    @ignore_case = opts && opts[:ignore_case] || false
    @char_map = Hash.new{|h,k| raise UnrecognizedCharacterError.new("the character `#{k.chr}' is not included in #{@chars}")}
    @num_map = {}
    @chars.split('').each_with_index do |c, i|
      if @ignore_case 
        @char_map[c[0]] = i
        @char_map[c.swapcase[0]] = i
      else
        @char_map[c[0]] = i
      end
      @num_map[i] = c
    end
  end
  
  def to_i(val)
    num = 0
    (0...val.size).each{|i| 
      num += (chars.size ** (val.size - i - 1)) * @char_map[val[i]]
    }
    num
  end
  
  def to_native(val, options = nil)
    str = ''
    until val.zero?
      digit = val % chars.size
      val /= chars.size
      str[0, 0] = @num_map[digit]
    end
    if options && options[:zero_pad]
      str[0, 0] = @num_map[0] * (options[:zero_pad] - str.size)
    end
    str == '' ? @num_map[0].dup : str
  end
  
  Hex          = Anybase.new('0123456789abcdef', :ignore_case => true)
  Base64       = Anybase.new('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/')
  Base64ForURL = Anybase.new('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_')
  Base62       = Anybase.new('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789')
  
end