#Programmers (or the good ones, anyway) value sim- plicity, and the simple thing to do here is to rigorously
#cancel out all of that flexibility, If you have no use for it, flexibility becomes a danger. All those names 
#and associations become just another way to screw up.
#the engineer is telling you something. Listen and don’t make the engineer tell you again.
#there is one thing that sets a good user interface apart from a bad one: If the user wants to do it 
#(whatever it is) a lot, it is the default. 

#A more considerate interface would make the more common case easy, while requiring somewhat more work
# for the less common case.

#We can give them a way to tell us what they want and not ask again. Engineers naturally tend to adopt
# conventions as a natural part of the way they work. 

#Designing a good convention, like designing any good user interface, involves putting yourself in your user’s
# shoes. Try to deduce how your users will behave, what they would call something, and where they would 
#naturally put things; then build your convention around those assumptions. 

require "net/smtp"
require "net/http"
require 'uri'

class Message
    def initialize(from, to, body)
        @from = from
        @to = to
        @body = body
    end
end

class SmtpAdapter
    URL_SERVER = 'localhost'.freeze
    URL_PORT = '25'.freez
    def send(message)
        #there is duplicate code with @ and message var use patternt instead of duplication
        from_adress = message.from.user + '@' + message.from.host
        to_adress = message.to.user + '@' + message.to.host
        email_text = "From: " + from_adress
        email_text += "To: " + to_adress
        email_text += "Subject: Email Sbj"
        email_text += "\n"
        email_text += messaget.text

        ::Net::SMTP.start(URL_SERVER, URL_PORT) do |smtp|
            smtp.send_message(email_text, from_adress, to_adress)
        end
    end
end

class HTTPAdapter
    def send(message)
        ::Net::HTTP.start(message.to.host, message.to.port) do |http|
            http.post(message.to.path, message.text)
        end 
    end
end

class FileAdapter
    def send(message)
        to_path = message.to.path
        to_path.slice!(0)
        File.open(to_path, 'w') do |file|
            file.write(message.text)
        end
    end 
end


#If all of the adapters follow this convention, then the system can pick the adapter class based on its name:
#With bolow approach, we have completely lost any hint of a configuration file—to add a new adapter, you simply add the adapter class.


#if we want to add classes but not want to add configs for sent appropriate adapter for demand
class MessageGateway
    def initialize
        load_adapter
    end
    def process_message(message)
       adapter = to_adapter(message)
       adapter.send(message)
    end
    def to_adapter(message)
        protocol = message.to.scheme.downcase
        adapter_name = "#{protocol.capitalize}Adapter"
        adapter_class = self.class.const_get(adapter_name)
        adapter_name.new
    end

    def load_adapter
        #file relative path with __FILE__ and append it to folder
        file_path = File.dirname(__FILE__)
        #join path with adapter folder
        full_path = File.join(file_path, 'adapter', "*.rb")
        #find all file with pattern and require it by calling block
        Dir.glob(full_path).each { |file| require_relative file }
    end
end 




#Name your authorization class <destination_host>Authorizer and put it in the auth directory. Implement the
# general policy for the host in the authorize method. If you have a special policy for a given user, 
#implement that policy in a method called <user>_authorized?.

def camel_case(string)
    string.splite('.').map(&:capitalize).join('Dot')
end
def authorize_for(message)
    to_host = message.to.host || 'default'
    authorizer_class = self.class.const_get(camel_case(to_host) + "Authorizer").new
end

class RussOlsenAuthorizer
    #<russ_dot_olsen_> create by our convention
    def russ_dot_olsen_authorized?(message)
        true
    end
    #if our user does not created default is this
    def authorized?(message)
        message.body.size < 2048
    end
end

def worm_case(string)
    #tokenize string and join again
    string.split('.').map(&:downcase).join("_dot_")
end
def authorized?(message)
    authorizer = authorize_for(message)
    user_method = worm_case(message.from) + '_authorized?'  #russ_dot_olsen_authorized? create here by our convention
    authorizer.send(message) if authorizert.respond_to?(user_method, message)
    authorizer.authorized?(message) unless authorizert.respond_to?(user_method)

end


#we noted that one of the principles of good interface design is to provide the user with templates
# and samples to help get started.



#create scaffold class

class Scaffold
    def initialize(protocol_name)
        @protocol_name = protocol_name
    end
    def create_protocol
        class_name = @protocol_name + "Protocol"
        file_name = File.dirname(__FILE__).join(class_name.downcase)

        scaffold = %Q {
            class #{class_name}
                def send(message)
                    #some code here
                end
            end
        }
        File.open(filename, 'w') { |file| file.write(scaffold) }
    end 
end 

Scaffold.new(ARGV[0])

#ruby <this_file>.rb <protocol_name>



#perhaps check for errors, and only then begin to set up our adapters and authorization classes. Instead, 
#we simply got on with the task of finding our adapters and authorizers.

#we need to supply a road map instead of configuiration file to user

#Another potential source of trouble is the possibility that a system that uses a lot of conventions may seem 
#like it is operating by magic to the new user. Configuration files may be a pain in the neck to write and 
#maintain, but they do provide a sort of road map—perhaps a very complicated and hard-to-interpret road map, 
#but a map nevertheless—to the inner workings of the system. A well-done convention-based system, by contrast, needs to supply its operational road map in the form of (gasp!) documentation.



#Convention Over Configuration says that you can sometimes build a friendlier system by binding your code
# together using conventions based on class names, method names, filenames, and a standard directory layout. 
#By doing so, you can make your programs easily exten- sible; you can extend your system by simply adding in 
#a properly named file or class or method.


#Translate Romeo and Juliet from English into Italian, and you will change the flow of the words, the feeling 
#of the work. Juliet will still be young and beautiful, but Juliet in Italian will somehow be a                                   
#little different. Translate a design pattern into a different language—into Ruby—and it is still the same, 
#but a little different.

#One thing that has not changed in the years since Design Patterns was published is the need for wisdom.
# Bruce Tate is fond of pointing out1 that when a new program- ming technique or language pops up, there is 
#frequently a wisdom gap. The industry needs time to come to grips with the new technique, to figure out the 
#best way to apply it. . How many years had to elapse between the first realization that object- oriented
# programming was the way to go and the time when we really began to use object-oriented technology effectively?
# Those years were the object-oriented wisdom gap.

#guages such as Ruby has plunged us into yet another wisdom gap. Ruby’s powerful fea- tures suggest different
# approaches to the programming problems with which we have wrestled for years. Ruby also gives us the power 
#to do things we have never thought of before. But what things should we do? Which shortcuts can we take safely?
# Which pitfalls must we avoid? With Ruby, we have all of this power at our fingertips, but we need some 
#guidance—some wisdom—to go with it. In this book, I have tried to shed a little light on what to do with the
# power of Ruby. But as we work our way through the new wisdom gap, we will uncover even more solutions, new 
#design patterns that will fit the dynamic, flexible world of Ruby.


