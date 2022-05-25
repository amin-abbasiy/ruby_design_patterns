#Although the GoF called the key method in the Interpreter pattern 'interpret', names such as 
# 'evaluate' or 'execute' also make sense and show up in code frequently.

#With the AST in hand, we are almost ready to evaluate our expression, save for one small detail:
# What is the value of x? To evaluate our expression, we need to sup- ply a value for x. Is x 
#equal to 1 or 167 or –279? The GoF called such values or con- ditions supplied at the time the 
#AST is interpreted the context. 
require 'find'

class Expression

end

class All < Expression
    def evaluate(dir)
        @results = []
        Find.find(dir) do |recursive_file|
            next unless Find.file?(recursive_file)
            @results << recursive_file
        end
        @results
    end
end

All.new.evaluate(Dir.pwd)

#Find All Files by name with pattern
class FileName < Expression
    def initialize(pattern)
        @pattern = pattern
    end 
    def evaluate(dir)
        @results = []
        Find.find(dir) do |file_|
            next unless Find.file?(dir)
            filename = File.basename(file_)
            @results << file_ if File.fnmatch(@pattern, filename)
        end
        @results
    end
end

FileName.new("*.mp3").evaluate(Dir.pwd)



class Bigger < Expression
    def initialize(size)
        @size = size 
    end

    def evaluate(dir)
        @results = []
        Find.find(dir) do |file_|
            next unless Find.file?(file_)
            @resluts << file_ if File.size(file_) > @size
        end
        @results
    end
end

Bigger.new(1024).evaluate(Dir.pwd)

class Writeable < Expression
    def evaluate(dir)
        @results = []
        Find.find(dir) do |file_|
          next unless Find.file?(file_)
          @results << file_ if File.writable?(file_)
        end
        @results
    end
end

Writeable.new.evaluate(Dir.pwd)


#Complex File Searches
class Not < Expression
    def initialize(expression_class)
        @expression_class = expression_class
    end
    def evaluate(dir)
        All.new.evaluate(dir) - @expression_class.evaluate(dir)
    end
end 

Not.new( Writeable.new ).evaluate(Dir.pwd)

class Or < Expression
    def initialize(ex_class_one, ex_class_two)
        @ex_class_one = ex_class_one
        @ex_class_two = ex_class_two
    end
    def evaluate(dir)
        (@ex_class_one.evaluate(dir) + @ex_class_two.evaluate(dir)).sort.uniq
    end
end
Or.new(Bigger.new(1024), FileName.new("*.png")).evaluate(Dir.pwd)

class And < Expression
    def initialize(ex_class_one, ex_class_two)
        @ex_class_one = ex_class_one
        @ex_clas_two - ex_class_two
    end
    def evaluate(dir)
        (@ex_class_one.evaluate(dir) & @ex_class_two.evaluate(dir))
    end
end

And.new(Writeable.new, FileName.new("*.jpg")).evaluate(Dir.pwd)

#and all Bigger 2048 files with writealbe and make AND result with pdf files and return in result
And.new(
    And.new(Bigger.new(2048), Writeable.new),
    FileName.new("*.pdf")
)

#Simple Parser for Create AST


class Parser
    def initialize(text)
        @tokens = text.scan(/\(|\)|[\w\.\*]+/)
    end
    def next_token
        @tokens.shift
    end
    def expression
        token = next_token
        case token
        when nil 
            return nil
        when '('
            result = expression
            raise ValueError, "Exptected )" unless next_token == ')'
            return result
        when 'all'
            return All.new(next_token)
        when 'writeable'
            return Writeable.new
        when 'filename'
            return FileName.new(next_token)
        when 'bigger'
            return Bigger.new(next_token.to_i)
        when 'and'
            return And.new(expression1, expression2)
        when 'or'
            return Or.new(expression1, expression2)
        when 'not'
            return Not.new(expression1)
        else
            raise ValueError, "Unexpected token: #{token}"
        end
    end
end 

::Parser.new( "and (and(bigger 1024)(filename *.mp3)) writable" ).expression


#Make Shortcut
class Expression
    def |(other)
        Or.new(self, other)
    end
    def &(other)
        And.new(self, other )
    end 
end


#Keep in mind that the main motivation behind building an interpreter is to give your users a natural way 
#to express the kind of processing that needs to be done. . If the ideas embodied in your interpreter can be 
#naturally expressed in XML or YAML, then go ahead and use that format and take full advantage of the
# built-in parser for that format.

#the Interpreter pattern adds a unique flexibility to your system.

#For all of its flexibility and power, the Interpreter pattern is not a good choice for the 2 percent of your
# code that really is performance sensitive. Of course, that does leave the remaining 98 percent wide open . . .

# As usual with the Interpreter pattern, the real power of Runt shines through when you start combining expressions.

# The Interpreter pattern is good at solving well-bounded problems such as query or configuration languages 
#and is a good option for combining chunks of existing functionality together.

#How you perform that decomposition is up to you: You can supply your clients with an API for building up the 
#tree in code, or you can write a parser that takes strings and turns them into the AST.