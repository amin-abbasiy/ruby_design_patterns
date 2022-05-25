require_relative 'composite_klass'
#leaf class  this is composite class with their subclasses and subtasks
class BatterTask < CompositeKlass
    def initialize
        super("make Batter")
        add_sub_task( AddDryIngredientsTask.new ) 
        add_sub_task( AddLiquidsTask.new )
        add_sub_task( MixTask.new )
    end
end

# class AddDryIngredientsTask
#     def get_time
#     end
# end 

# class AddLiquidsTask
#     def get_time
        
#     end
# end 

# class MixTask
#     def get_time
    
#     end 
# end