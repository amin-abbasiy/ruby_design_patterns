class Employee
    include Observerable
    def initialize(name, position, salary)

    end
    def salary=(new_salary)
        @salary = new_salary
        changed
        #in each call below method chaged flag set to false
        notify_observers(self)
    end
end 