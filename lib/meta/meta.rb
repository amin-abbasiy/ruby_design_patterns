#Perhaps we can extract out the common aspects of these two problems and implement a single software facility
# to solve both problems in one go.
#Sometimes the best way to approach a task like this one is to imagine what we want the end result to look like 
#and then work backward to an implementation.
class CompositeBase
    def initialize(name)
        @name = name 
    end
    def self.member_of(composite_name)
        code = %Q{
            attr_accessor :parent_#{composite_name}
        }
        attr_name = "parent_#{composite_name}"
        raise 'Method redefinition' if instance_methods.include?(attr_name)
        class_eval(code)
    end
    def self.composite_of(composite_name)
        code =  %Q{
            def sub_#{composite_name}s
                @sub_#{composite_name}s || []
            end
            def add_sub_#{composite_name}(child)
                @sub_#{composite_name}s << child if child
                @sub_#{composite_name}s
                child.parent_#{composite_name} = self
            end
            def delete_sub_#{composite_of}(child)
                @sub_#{composite_name}s.delete(child) if @sub_#{composite_name}s.include?(child)
                @sub_#{composite_name}s
                child.parent_#{composite_name} = nil
            end
        }
        class_eval(code)
    end
end

class Tiger < CompositeBase
    member_of(:population)
    member_of(:classification)
end

class Jungle < CompositeBase
    composite_of(:population)
end

class Tree < CompositeBase
    member_of(:population)
    member_of(:classification)
end

class Species < CompositeBase
    composite_of(:classification)
end

jungle = Jungle.new("WestWood")
tiger = Tiger.new("Tom")
jungle.add_sub_population(tiger)
tiger.parent_classification

#Reflection features like public_methods and respond_to? are handy anytime but become real assets as you dive 
#deeper and deeper into meta-programming, when what your objects can do depends more on their history than on 
#their class.

#tests are absolutely mandatory for systems that use a lot of meta- programming.


#make class macro

class Object
    def self.attr_readable(name)
        code = %Q {
            def #{name}
                @#{name}
            end
        }
        class_eval(code)
    end
end 

class Example
    attr_readable :mtd_name
    def initialize(mtd_name)
        @mtd_name = mtd_name
    end
end