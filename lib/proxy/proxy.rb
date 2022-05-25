class BankAccount
    attr_accessor :starting_balance
    def initialize(starting_balance=0)
        @balance = starting_balance
    end
    def deposit(amount)
        @balance += amount
    end 
    def withdraw(amount)
        @balance -= amount
    end
end 
class BankAccountProxy
    attr_accessor :real_object
    def initialize(real_object)
        @real_object = real_object
    end 
    def deposit(amount)
        @real_object.deposit(amount)
    end
    def withdraw(amount)
        @real_object.withdraw(amount)
    end 
end

account = BankAccount.new(100)
account.deposit(1000)
account.withdraw(100)

proxy = BankAccountProxy.new(account)
proxy.deposit(2000)
proxy.withdraw(300)


#But once we have a proxy, we have a place to stand squarely between the client
# and the real object. If we want to manage who does what to the bank account, 
#the proxy provides the ideal pinch point to exert control.


#this is the implement controll access on real object actions by proxy class
require 'etc'
class AccoutProtectionProxy
    def initialize(real_object, owner_name)
        @real_object = real_object
        @owner_name = owner_name
    end
    def deposit(amount)
        check_access
        @real_object.deposit(amount)
    end 
    def withdraw(amount)
        check_access
        @real_object.withdraw(amount)
    end 
    def balance
        check_access
        @real_object.balance
    end
    def check_access
        raist "Ileggal Attempt for #{Etc.getlogin}" if @owner_name != Etc.getlogin
    end 
end 


#Add Account Protection Proxy with ghoast methods and dynamic methods

class AccoutProtectionProxy
    attr_accessor :real_object
    def initialize(real_object)
        @subject = real_object
    end 

    def method_missing(name, args, &block)
        check_access
        puts "Method Deligation for method #{name}"
        #One
        @subject.send(name.to_sym, arges, block)
        @subject.name(args, block) #my way
    end
    #my dynamic way
    mtds = [:balance, :deposit, :withdraw]
    define_method(mtds, args, &block) do |mtd|
        check_access
        puts "Deligation Dynamic for #{mtd}"
        @subject.send(mtd, args, block)
    end
    def check_access
        raise "Ileggal Access Requiest" if Etc.getlogin != @owner_name.name
    end 
end

AccoutProtectionProxy.new { BankAccount.new( 100 ) }