#component base class 
class Task 
    attr_reader :name, :parent
    def initialize(name)
        @name = name
        @parent = nil
    end 
    def get_time

    end
    def total_tasks
        1
    end 
end 