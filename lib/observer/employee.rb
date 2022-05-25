class Employee
    def initialize(name, position, salary, payroll)
        @name = name
        @position = position
        @salary = salary
        @payroll = payroll
    end
    def salary=(new_salary)
        @salary = new_salary
        @payroll.update(salary: new_salary)
    end
end
instance = Employee.new("amin", 'back-end', '111', Payroll.new)
instance.salary = '1111'



#What we seem to need is a list of objects that are interested in hearing about 
#the latest news from the Employee object. We can set up an array for just that 
#purpose in the initialize method:

#OBserver Mode
#this also is subject class that impelement inteface between observers and its news to inform them
class Employee
    def initialize(name, position, salary)
        @name = name
        @position = position
        @salary = salary
        @observers = []
    end
    def salary=(new_salary)
        @salary = new_salary
        @observers.each do |observer|
            observer.update(new_salary)
        end 
    end
    def add_observer(observer)
        @observers << observer
    end 
    def delete_observer(observer)
        @observers.delete(observer)
    end 
end



#By creating a clean interface between the source of the news (the observable object) and
#the consumer of that news (the observers), the Observer pattern moves the news without tangling things up.