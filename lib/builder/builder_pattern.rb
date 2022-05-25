#The builder class takes charge of assembling all of the components of a complex object.
# Each builder has an interface that lets you specify the configuration of your new object step by step
#  In a sense, a builder is sort of like a multipart new method, where objects are created 
#in an extended process instead of all in one shot.

#The GOF called the client of the builder object the director because it directs the builder in 
#the construction of the new object (called the product). Builders not only ease the burden of 
#creating complex objects, but also hide the implementation details.

#Without Builder
class Computer
    attr_accessor :cpu, :motherboard, :drives
    def initialize(cpu, motherboard, drives =[])
        @cpu = cpu
        @motherboard = motherboard
        @drives = drives
    end
end

class Cpu
    def initialize(type)
        const_get("#{type}Cpu").new
    end
end

class BasicCpu < Cpu
#some codes here
end

class TurboCpu < Cpu
#some coders here
end

class Drive 
    def initialize(writeable, type, size)

    end
end

class MotherBoard
    def initialize(cpu=BasicCpu.new, mem_size=1024)

    end
end

Drive.new ...
MotherBoard.new ... 
TurboCpu.new ...
#other class instantiation


#The Builder pattern way
class ComputerBuilder
    attr_reader :computer
    def initialize
        @computer = ::Computer.new
    end
    def turbo(has_cpu_turbo= true)
        @computer.motherboard.cpu = TurboCpu.new
    end
    def display(display)
        @computer.display = display
    end
    def memory_size(size_of_mem = 1024)
        @computer.motherboard.memory_size = size_of_mem
    end
    def add_cd
        @computer.drives << Drive.new(is_writeable, size, :cd)
    end
    def add_dvd
        @computer.drives << Drive.new(is_writeable, 2048, :dvd)
    end
    def add_hard_disk
        @computer.drives << Drive.new(is_writeable, 4096, :hdd)
    end
end

#Factoring out all of that nasty construction code is the main motivation behind builders.




#Polymorphic Builder

#we can refactor our builder into a base class and two subclasses to take care of these differences.
#The abstract base builder deals with all of the details that are common to the two kinds of computers

class Computer
#codes
end

class ComputerBuilder
#codes 
end 

class LaptopComputer < Computer

end

class DesktopComputer < Computer

end

class LaptopBuilder < ComputerBuilder
    def initialize
       @computer = LaptopComputer.new 
    end
    def display=(display)
        @computer.display = display
    end 
    def add_cd(size= 512)
        @computer.drives << LaptopDrive.new(:not_writeable, :cd, size)
    end
end

class DesktopBuilder < ComputerBuilder
    def initialize
        @computer = DesktopBuilder.new 
    end
    def add_cd(size= 2048)
        @computer.drives << ::Drive.new(:is_writeable, :cd, 4096)
    end
end


#Ensure of Sane Objects
#...
# if ! hard_disk
#     raise "No room to add hard disk." if @computer.drives.size >= 4
#       add_hard_disk(100000)
# end
#...

#3 Reusable Builders
instance = LaptopBuilder.new
instance.display(42)
instance.hard_drive(1024)
#for create another one by reset
class LaptopBuilder
    def reset
        LaptopBuilder.new
    end
end

#If you want to perform the configuration once and then have the builder produce any number of 
#objects based on that configuration, you need to store all of the configuration informa- tion in 
#instance attributes and create the actual product only when the client asks for it.

#4 Use Magic
builder.add_dvd_and_cd_and_hdd_and_turbo

def method_missing(name, *args)
    words = name.split('_')
    #raise default not method error in Object class if not here
    super(name, *args) unless if words.shift == 'add'
    #calls methods one by one
    words.each do |word|
        next if word == 'and'
        add_cd if word == 'cd'
        add_dvd if word == 'dvd'
        add_hdd(1024) if word == 'hdd'
        turbo if word == 'turbo'
    end
end

#You can find the same object creation logic scat- tered all over the place. Another hint that
# you need a builder is when your code starts producing invalid objects: “Oops, I checked the 
#number of drives when I create a new Computer over here, but not over there.”