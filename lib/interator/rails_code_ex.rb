def superclass_of(superclass)
    result_subclasses = []
    ObjectSpace.each_object(Class) do |klass|
        #I Seperate one next if to two next if because they are or relation together
        next if !klass.ancestors.include?(superclass) || klass == superclass
        next if klass.to_s.include?('::') || result_subclasses.include?(klass.to_s)
        result_subclasses << klass.to_s
    end
    result_subclasses
end 