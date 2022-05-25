require_relative 'task'
#leaf Class 
class AddDryIngredient < Task
    def initialize
        super("add Dry Ones")
    end 
    def get_time
        1
    end     
end