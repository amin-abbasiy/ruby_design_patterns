sentence = 'this string start with S to find and Scan it for s word'
sentence.scan(/[Ss]\w*/) { |word| puts word }