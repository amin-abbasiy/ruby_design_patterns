var = lambda { |var| puts "Lambda" }
var.call(12)

#Implicit 
def im_test #block given is invisible
    yield(32)
end

im_test do |var|
    puts var * var
    puts "Yield Implicit"
end 

#Explicit
def ex_test(&block)
   puts block.call(10) if block_given?
   puts "Explicit"
end 

ex_test do |var| #block passing
    var + var
end

l_ambda = lambda { |var| var - var }
ex_test(&l_ambda) #before pass lambda proc must convert it to block