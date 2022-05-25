class Fight
    def initialize(sport)
        @sport = sport[0]
    end
    #template method
    def determinate
        instance = Module.const_set(@sport.upcase).new
        puts instance.descripiton
        puts instance.pants
    end
    #hook method it fill just in sports has pants
    def pants

    end
    #abstract method its common between all sprots 
    def descripiton
        "Start To Know #{title}"
    end
    def title
       "Basic Title"
    end 
end 

ins = Fight.new(ARGV)
ins.determinate