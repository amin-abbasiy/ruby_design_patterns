#this is adapter class #this class cross client interface to adaptee
# this is adaptee @string[@position] actually do the work
class StringAdapter
    def initialize(string, position)
        @string = string
        @position = position
    end 
    def getc
        raise EOFError if @position >= @string.length
        char = @string[@position]
        @position += 1
        char
    end 
    def eof?
        @position >= @string.size
    end 
end 
#client requrest for data 
class Encrypter
    def initialize(key)
        @key = key
    end
    def encrypt(reader, writer)
        key_index = 0
        while not reader.eof?
            clear_char = reader.getc
            encrypted_char = clear_char ^ @key[key_index]
            writer.putc encrypted_char
            key_index = (key_index + 1) % @key.size
        end 
    end 
end
reader = ""
Encrypter.new('secret key').encrypt(reader, writer)