class EnhanceWriter
    attr_accessor :check_sum
    def initialize(path)
        @file = File.open(path, 'w')
        @check_sum = 0
        @line_number = 1
    end
    def write_line(line)
        @file.print(line)
        @file.print('\n')
    end
    def write_with_line_number(line)
        write_line("#{@line_number} #{line}")
        @line_number += 1
    end 
    def write_check_sum(line)
        line.each_byte { |byte| (@check_sum + byte) % 256 }
        @check_sum += "\n"[0] % 256
        write_line(@check_sum)
        write_line(line)
    end
    def write_with_timestamp(line)
        write_line("#{Time.now} #{line}")
    end 
    def close
        @file.close
    end 
end 

EnhanceWriter.new("/Users/amin/RubymineProjects/Projects/Ruby/DesignPattern/lib/decorator/file.txt").write_check_sum("file DAta")



#If you want your lines numbered, insert an object (perhaps one called NumberingWriter) between your SimpleWriter and the client,
# an object that adds a number to each line and forwards the whole thing on to the basic SimpleWriter, which then writes it to disk.
# NumberingWriter adds its own contribution to the abil- ities of SimpleWriter—in a sense, it decorates SimpleWriter;

#Because the NumberingWriter class presents the same core interface as the plain old writer, the client does not really have to worry
#about the fact that it is talking to a NumberingWriter instead of a plain old SimpleWriter. At their most basic, both flavors of 
#writer look exactly the same.

class SimpleWriter
    attr_accessor :file
    def initialize(path)
        @file = File.open(path, 'w')
    end
    def line_writer(line)
         @file.print(line)
         @file.print("\n")
    end
    def pos
        @file.pos 
    end 
    def rewind
        @file.rewind
    end
    def close
        @file.close
    end
end

class WriterDecorator
    #class SimpleWriter methods because of being same interface
    attr_accessor :real_object
    def initialize(real_object)
        @real_object = real_object
    end
    def line_writer(data)
        @real_object.line_writer(data)
    end
    def pos
        @real_object.pos
    end
    def rewind
        real_object.rewind
    end 
    def close
        real_object.close
    end
end 

def LineDecorator < WriterDecorator
    def initialize(real_object)
        super(real_object)
        @line_number = 1
    end
    def line_writer(data)
        @real_object.line_writer("#{@line_number} #{data}")
        @line_number += 1
    end
end
#The CheckSummingWriter is a little different from our first decorator in that it has an enhanced interface.
class CheckSumDecorator < WriterDecorator
    atrr_accessor :check_sum
    def initialize(real_object)
        @real_object = real_object
        @check_sum = 0 
    end
    def line_writer(data)
        data.each_byte {|byte| (@check_sum + byte) % 256 }
        @check_sum += "\n"[0] % 256
        @real_object.line_writer("#{@check_sum} #{data}")
    end 
end
class TimeStampDecorator < WriterDecorator
    def initialize(real_object)
        @real_object = real_object
    end 
    def line_writer(data)
        @real_object.line_writer("#{Time.now} #{data}")
    end
end 

#Now here is the punchline: Because all of the decorator objects support the same basic interface as the original, the “real” object
#that we supply to any one of the deco- rators does not actually have to be an instance of SimpleWriter—it can, in fact, be any other
# decorator. 

writer_data = CheckSumDecorator.new( TimeStampDecorator.new( LineDecorator.new( SimpleWriter.new( 'file.txt' ) ) ) )
writer_data.line_writer(" Text Enter in Checksum Decorator ")

#With Forwardable Method Component class Decorator Writer is Like this

class WriterDecorator
    extend forwardable
    #class SimpleWriter methods because of being same interface
    attr_accessor :real_object
    def initialize(real_object)
        @real_object = real_object
    end
    #this deligate like up class
    def_deligator :@real_object, :line_writer, :pos, :rewind, :close
end 



#method wrapper way

w = SimpleWriter.new('file.txt')

class << w 
    alias :old_write_line :write_line
    def write_line(data)
        old_write_line("#{Time.now} #{data}")
    end 
end


#module way

module LineDecorator
    attr_accessor :line_number
    def initialize
        @line_number = line_number
    end 
    def write_line(line)
        @line_number = 1 unless @line_number
        super("#{@line_number} #{line}")
        @line_number += 1
    end
end 
module CheckSumDecorator
     
end


module  TimeStampDecorator
    def write_line(line)
        super("#{Time.new}: #{line}")
    end
end

#The last module added will be the first one called.
w = SimpleWriter.new('out') 
w.extend(NumberingWriter) 
w.extend(TimeStampingWriter)
w.write_line('hello')
