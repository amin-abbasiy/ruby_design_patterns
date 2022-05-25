class Duck
    def initialize(name)
        @name = name
    end
    def eat
        puts("Duck #{@name} Eating")
    end
    def speak
        puts("Duck #{@name} Quaking")
    end
    def sleep
        puts("Duck #{@name} Sleeping")
    end
end

def Frog
    def initialize(name)
        @name = name
    end
    def eat
        puts("Frog #{@name} Eating")
    end
    def speak
        puts("Frog #{@name} Coorking")
    end
    def sleep
        puts("Frog #{@name} Sleeping")
    end
end

class Pond
    def initialize(number_ducks)
        @ducks = []
        number_ducks.each do |duck|
            instance = Dock.new(duck)
            @ducks << instance 
        end
    end
    def daily_life
        @ducks.each { |duck_ins| " #{duck_ins.eat} and #{duck_ins.speak} #{duck_ins.sleep}" }
    end
end



#Creators BaseClass and ConcreteClasses 
class Pond
    def initialize(number_animals)
        @animals = []
        number_animals.times do |number|
            animal =  new_animal("Animal #{number}")
            @animals << animal
        end
    end
    def simulate_day
        @animals.each { |animal| animal.speak }
    end
    # def factory_method

    # end
end
class DuckPond < Pond
    def new_animal(name)
        Duck.new(name)
    end 

    #you can call product class functionality with one you instantiated
    #@animal -> do what you want

    # def factory_method

    # end
end
class FrogPond < Pond
    def new_animal(name)
        Frog.new(name)
    end 
    # def factory_method

    # end
end

#Product Classes
class Duck
    def initialize(name)
        @name = name
    end
    def speak
        puts ("Duck #{@name} is Quaking")
    end
end
class Frog
    def initialize(name)
        @name = name
    end
    def speak
        puts ("Frog #{@name} is Quaking")
    end
end

make_duck_instance = DuckPond.new(3)
make_duck_instance.simulate_day





#Parameterized Factory Methods

class Pond 
    def initialize(new_animals, animal_class, new_plants, plant_class)
        @animals = []
        new_animals.times do |number|
            animal = new_organism(:animal, number)
            @animals << animal
        end

        @plants = []
        new_plants.times do |number|
            plant = new_organism(:plant, number)
            @plants << plant
        end
    end

    def simulate_one_day
        @animals.each do |animal|
            animal.speak
        end
        @plants.each do |plant|
            @plant.grow
        end
    end
    
    def new_organism(type, name)
        new_animal(name) if type == :animal
        new_plant(name) if type == :plant
        return TypeError, "No Such Organism Exists" unless type == :animal || :plant
    end 
end
class TypeError < StandardError; end;
class RosePond < Pond
  def new_plant(name)
    Rose.new(name)
  end
end 

class Rose
    def initialize(name)
        @name = name
    end
    def grow
        puts("Rose #{@name} is Growing")
    end
end

