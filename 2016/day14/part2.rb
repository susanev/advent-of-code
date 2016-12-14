# susan evans
# last edited 12/14/2016
# advent of code 2016, day 14, part 2

# Generates stretched (2016 times) keys using MD5, using @salt.
# The keys must have a character that repeats 3 times in a row, and one of the next 1000 hashes must repeat that same character 5 times in a row.
# Outputs the 64th key that is generated.

class Part2
  require 'digest/md5'

  CONST_NUM_KEYS = 64
  CONST_WITHIN = 1000

  def initialize(file_name)
    @keys = []
    @salt = File.open(file_name, "r").first
    generate_keys
    output
  end

  def generate_keys
    md5_index = 0
    # stores keys with 3 characters repeated
    maybe_keys = {}
    until @keys.length >= CONST_NUM_KEYS do 
      md5 = Digest::MD5.hexdigest(@salt + md5_index.to_s)
      # is there a better way to do this??
      2016.times do
        md5 = Digest::MD5.hexdigest(md5)
      end
      if result = contains_repeat(md5, 3)
        maybe_keys[md5] =  {:repeat => result, :index =>md5_index}
      end
      if result = contains_repeat(md5, 5)
        maybe_keys.each do |k,v| 
          if valid_key?(result, md5_index, v) 
            @keys.push(v[:index])
            maybe_keys.delete(k)
          end
        end
      end
      md5_index += 1
    end
  end

  # matches repeated character, is not itself, and has an index within
  # the CONST_WITHIN limit
  def valid_key? (match, match_index, value)
    match == value[:repeat] && 
      match_index != value[:index] && 
      match_index - value[:index] < CONST_WITHIN
  end

  # returns nil if no repeat, otherwise returns the single
  # character that was repeated
  def contains_repeat(md5, repeat)
    if (result = md5[/((.)\2{#{repeat-1}})/]).nil?
      return nil
    else
      return result[0]
    end
  end

  def output
    puts "#{@keys[CONST_NUM_KEYS - 1]} produces the 64th one-time pad key"
  end
end

Part2.new("input.txt")