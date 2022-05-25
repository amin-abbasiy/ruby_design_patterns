class Habitant
    def initialize(number_of_animanls, number_of_plants, organism_factory)
        @organism_factory = organism_factory
        @animals = []
        number_of_animanls.times do |animal|
            @organism_factory.new_animal(animal)
            @animals << animal
        end

        @plants = []
        number_of_plants.times do |plant|
            @organism_factory.new_plant(plant)
            @plants << plant
        end
    end
end

class JungleFactory
    def new_animal(name)
        Tiger.new(name)
    end
    def new_plant(name)
        Tree.new(name)
    end
end

class PondFactory 
    def new_animal(name)
        Frog.new(name)
    end
    def new_plant(name)
        Algae.new(name)
    end 
end

#2
#class-based abstract factory. Instead of having several dif- ferent abstract factory classes
class OrganisamFactory
    def initialize(new_animal, new_plant)
        @animal_class = new_animal
        @plant_class = new_plant
    end 
    def new_animal
        @animal_class.new(name)
    end
    def new_plant
        @plant_class.new(name)
    end 
end


jungle_organisam_factory = OrganisamFactory.new(Tree, Tiger)
pond_organism_factory = OrganisamFactory.new(Frog, Flora)

::Habitant.new(3, 4, jungle_organisam_factory).simulate_one_day
::Habitant.new(5, 6, pond_organism_factory).simulate_one_day


#The important thing about the abstract factory is that it encapsulates the knowledge
# of which product types go together. You can express that encapsulation with classes and
# subclasses, or you can get to it by storing the class objects as we did in the code above. Either way, you end up with an object that knows which kind of things belong together.



#Leveraging the Name
class IOFacotory
    def initialize(format_name)
        @reader_class = const_get("#{format_name}Reader")
        @writer_class = const_get("#{format_name}Writer")
    end
    def new_reader
        @reader_class.new
    end
    def new_writer
        @writer_class.new
    end
end

::IOFacotory.new("HTML").new_reader


#Use the techniques discussed in this chapter when you have a choice of several different, 
#related classes and you need to choose among them.



#The Factory Method pattern involves the application of the Template Method pattern to object creation. 