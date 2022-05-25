require 'madeleine'

class Example

end 


Thread.new do 
    while true
        sleep(20)
        Example.new.take_snapshot
    end
end 