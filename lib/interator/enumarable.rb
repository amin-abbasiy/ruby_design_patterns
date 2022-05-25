class Account
    attr_accessor :name, :balance
    def initialize(name, balance)
        @name = name
        @balance = balance
    end
    def <=>(other)
        @balance <=> other.balance
    end
end
class Protofilio
    def initialize
        @accounts = []
    end 
    def each(&block)
        @accounts.each(&block)
    end
    def add_account(account)
        @accounts << account
    end 
end
account = Account.new('amin', 2000)
protofilio = ::Protofilio.new

protofilio.all? { |account| account.balance > 100 }