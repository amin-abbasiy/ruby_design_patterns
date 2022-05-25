#this is Sterategy class 
class Detector
    def show_properties
       raise NameError, "This Is Abstract Class"
    end 
end
class Car < Detector
    def show_properties(name)
         #TODO Sharing Data between the Context and the Strategy
        puts name + " Car" #if we pass context class we cat call self.name_
    end 
end 
class MotorBike < Detector
    def show_properties(name)
        puts name + " Motor"
    end
end 