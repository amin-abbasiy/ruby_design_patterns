class ArrayIterator
    def initialize(arr)
        #TODO for problem of threads we can make a copy of array
        # @arr = Array.new(arr) #this is copy of array
        @arr = arr
        @idx = 0
    end
    def has_next?
        @idx < @arr.length
    end
    def next_item
        value = @arr[@idx]
        @idx += 1
        value
    end
    def item
        @arr[@idx]
    end 
    def merge(arr1, arr2)
        merged = []
        #merge one by one with index
        while arr1.has_next? && arr2.has_next?
            if arr1.item > arr2.item
                merged << arr2.next_item
            else 
                merged << arr1.next_item
            end 
        end
        #merge rest of arr1
        while arr1.has_next?
            merged << arr1.next_item
        end
        #merge rest of arr2
        while arr2.has_next?
            merged << arr2.next_item
        end
        puts merged
    end 
end

ins = ArrayIterator.new(['qmin', 'name', 'salad'])
ins2 = ArrayIterator.new(['s+amin', 'field', 'check'])
# while ins.has_next?
#     puts ins.next_item
# end

ins.merge(ins, ins2)