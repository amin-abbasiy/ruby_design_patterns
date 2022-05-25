class SlickButton
    attr_accessor :block
    def initialize(&block)
        @command = block
    end 
    def push_on_button
        @command.call if @command
    end 
end 

class SaveCommand
    def execute

    end 
end

::SlickButton.new do 
    #some code 

end 
