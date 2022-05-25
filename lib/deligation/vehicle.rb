require_relative 'detecter'
#The strategies have their interface; the con- text simply uses that interface. 
#This Is context Class
class Vehicle
    attr_reader :name_
    attr_accessor :vehicle_type
    def initialize(vehicle_type)
      @vehicle_type = vehicle_type
      @name_ = "Name Default"
    end
    def show_properties
      #TODO Sharing Data between the Context and the Strategy
      @vehicle_type.show_properties(@name_) #we can pass self(context class for self reference) and class @name_ under self object
      #TODO in duck typing we pass self context class in show method
      #@vehicle_type.show_properties(self)
    end 
end
ins = Vehicle.new(Car.new)
ins.show_properties


#TODO if ruby world for Duck Typing we delete Detecter Base Class and implement all in vehicle.rb file
class Car
  def show_properties(context)
       #TODO Sharing Data between the Context and the Strategy
      puts context.name + " Car" #if we pass context class we cat call self.name_
  end 
end 
class MotorBike
  def show_properties(context)
      puts context.name + " Motor"
  end
end

#for simple interface we can use block instead class way
class Vehicle
  def initialize(&formatter)
    @name = "Amin"
    @formatter = formatter
  end  
  def show_properties
    @formatter.call(self)
  end
  HTML_FORMATTER = lambda do |name|
    puts name
  end 
end

#The easiest way to go wrong with the Strategy pattern is to get the interface between the context
#and the strategy object wrong. Bear in mind that you are trying to tease an entire, consistent, 
# and more or less self-contained job out of the context object and delegate it to the strategy.
#You need to pay particular attention to the details of the interface between the context and the 
#strategy as well as to the coupling between them. Remember, the Strategy pattern will do you little 
#good if you couple the con- text and your first strategy so tightly together that you cannot wedge a 
#second or a third strategy into the design