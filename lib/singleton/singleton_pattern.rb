class SimpleLogger
    ERROR = 1
    WARNING = 2
    INFO = 3
    def initialize
        @file = File.open("file.log", "w")
        @level = INFO
    end 

    def error
        @file.puts(msg)
        @file.flush
    end 

    def warning
        @file.puts(msg) if @level >= WARNING
        @file.flush
    end

    def info
        @file.puts(msg) if @level >= INFO
        @file.flush
    end


    #the singleton way 
    @@instace = SimpleLogger.new

    def instance 
        return @@instace
    end

    #to prevent instantiate our class more than once and make it secure
    private_class_method :new
end

logger = SimpleLogger.new logger.level = SimpleLogger::INFO
logger.info('Doing the first thing')
logger.info('Now doing the second thing')

#the singleton way
SimpleLogger.instance.warning("Warning Raise")



#user class as singletons
#this solve single instantiation but not solve eager instatiation
class ClassBasedLogger
    ERROR = 1
    WARNING = 2
    INFO = 3
    @@level = WARN
    @@logger = File.open("file.log")

    def self.error(msg)
        @@logger.puts(msg)
        @@logger.flush
    end
    def self.warning(msg)
        if @@level <= 2
            @@logger.puts(msg)
            @@logger.flush
        end
    end
    def self.info(msg)
        if @@logger <= 3
            @@logger.puts(msg)
            @@logger.flush
        end
    end
end

#we can implement module based singleton with no able to instatiation




#We might, of course, override the clone method in ClassBasedLogger to pre- vent unauthorized cloning. 

a_second_logger = ClassBasedLogger.clone
a_second_logger.error('using a second logger')