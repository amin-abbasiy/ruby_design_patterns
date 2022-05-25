#this is target class and user want to render without knowing about british or us way
class Renderer
    def render(text_obj)
        @text = text_obj.text
        @size_in_inch = text_obj.size_in_inch
        @color = text_obj.color

        #render some data
    end 
end
#this is Adapter class can interfact between render and brithish class
class TextObject
    attr_accessor :text, :size_in_inch, :color
    def initialize
        @text = text
        @size_in_inch = size_in_inch
        @color = color
    end 
end 

#this is adaptee class which actually do the work
class BritishColorObject < TextObject
    def initialize(bto)
        @bto = bto
    end
    def text
        @bto.string
    end 
    def size_in_inch
        @bto..size_mm / 25.4 
    end 
    def color 
        @bto.colour
    end 
end


#for less aggresive way we can prevent edit all class on the fly #this is a change for BritishTextObject class
bto = BritishTextObject.new('hello', 50.8, :blue)

class << bto 
    #this way class << bto is the same as bto.text and ... 
    def text
        @bto.string
    end 
    def size_in_inch
        @bto..size_mm / 25.4 
    end 
    def color 
        @bto.colour
    end 
end 