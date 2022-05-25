class Me
    def method_missing(mtd, *args, &block)
        block.call if block_given?
    end
end

Me.new.hello do 
    puts "amin"
end 