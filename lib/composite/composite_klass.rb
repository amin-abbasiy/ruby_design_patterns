require 'task'
class CompositeKlass
    def initialize(name)
        super(name)
        @subtasks = []
    end
    def add_sub_task
        @subtasks << task
        task.parent = self
    end
    def remove_subtask(task)
        @subtasks.delete(task)
        task.parent = nil
    end
    def get_time
        time = 0
        time = @subtasks.collect(&:get_time)
    end
    #because this class is composite because of ints sub-components and is component because is component of Task class
    #these method can be apply for tidier design in composite pattern
    #we can inherit array for free get these methods by its not good way because these three methods are Task Not Array
    def <<(task)
        @subtasks << task
    end 
    def [](index)
        @subtasks[index]
    end
    def []=(index, value)
        @subtasks[index] = value
    end
    #get all tasks number
    def total_tasks
        total = 0
        @subtasks.each { |inat| total += ins.total_tasks }
        total
    end 
end

#Three Mtd
composite = CompositeKlass.new("amin")
composite[1] = "ADDSugar"
puts composite[1]
composite << "AddMilk"
puts composite.last

puts composite.get_time