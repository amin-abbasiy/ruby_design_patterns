module Subject
    def initialize
        @observers = []
    end
end 

class Employee
    def initialize(name, position, salary)
        super() #we use parantheses to tell ruby super with no args #if not ruby call super with default args (name, position, salary)
        @name = name
        @position = position
        @salary = salary
    end
    def salary=(new_salary)
        @salary = new_salary
        notify_observers
    end
    def notify_observers(salary)
        @observers.each do |observer|
            observer.update(self)
        end 
    end 
end


#The key decisions that you need to make when implementing the Observer pattern all center on the
#interface between the subject and the observer. 