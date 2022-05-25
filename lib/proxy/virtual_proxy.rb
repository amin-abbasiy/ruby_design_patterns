#This is for Real Bank Account

class VirtualBankAccount
    # attr_accessor :starting_balance
    # def initialize(starting_balance=0)
    #    @starting_balance = starting_balance
    attr_accessor :real_block
    def initialize(&real_block)
        @real_block = real_block
    end
    def deposit(amount)
        s = @subject
        @subject.deposit(amount)
    end
    def withdraw(amount)
        s = @subject
        @subject.withdraw(amount)
    end
    def balance
        s = @subject
        @subject.balance 
    end 
    def subject
        @subject = @real_block.call
        #this way in less dynamic we use block codes instead
        # @subject ||= ::BankAccount.new( 100 )
    end 
end

account = ::VirtualBankAccount.new { ::BankAccount.new ( 200 ) }





#Like the other two flavors of proxies, the virtual proxy provides us with a good separation 
#of concerns: The real BankAccount object deals with deposits and with- drawals, while the 
#VirtualAccountProxy deals with the issue of when to create the BankAccount instance.


#Dynamic way and Ghoast

class VirtualBankAccount
    attr_accessor :real_object

    def initialize(&real_object)
        @real_object = real_object
    end 
    def method_missing(name, args, &block)
        puts "Ghoast method deligation for #{name}"
        s = @subject
        s.send(name, args, block)
        #my way
        s.name(args, block)  
    end
    #my dynamic way
    mtds = [:balance, :deposit, :withdraw]
    define_method(mtds, args, block) do |name|
        puts "Dynamic Deligation for #{name}"
        s.send(name, args, block)
    end   
    #my dynamic way 
    def subject
        @subject ||= @real_block.call
    end
end

account = VirtualBankAccount.new { ::BankAccount.new( 200 ) }