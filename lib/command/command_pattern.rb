class Command
    attr_accessor :description
    def initialize(description)

    end

    def execute

    end
end

class CreateFile < Command
    attr_accessor :path, :contents
    def initialize(path, contents)
        super("Create File in Path: #{path}")
        @path = path
        @contents = contents 
    end
    def execute
        file = File.open(@path, 'w')
        file.write(@contents)
        file.close
    end
    def unexecute
        #TODO this is destructive i should save its value for in user wants to Redo Action
        File.delete(@path) if File.exists?(@path)
    end 
end

class DeleteFile < Command
    attr_accessor :path, :content
    def initialize(path)
        super("Delete File From Path: #{path}")
        @path = path
    end
    def execute
        @content = File.open(@path).read
        File.delete(@path)
    end
    def unexecute
       file = File.open(@path, 'w').write(@content).close if @content
    end 
end

class CopyFile < Command
    attr_accessor :source, :target
    def initialize(source, target)
        super("Copy File From Source #{source} To Target #{target}") #for assing value to description in CommandClass
        @source = source
        @target = target
    end
    def execute
        FileUtils.copy(@source, @target)
    end
    def unexecute
        File.delete(@target) if File.exists?(@target)
    end
end

#This CompostieCommand Pattern for Keep track of objects

class CommpositeCommand < Command
    def initialize
        @commands = []
    end
    def add_command
        @commands << @command
    end
    def execute
        @commands.each { |cmd| cmd.execute }
    end
    def unexecute
        @commands.reverse.each { |cmd| cmd.unexecute }
    end 
    def description
        description = ''
        @commands.each { |cmd| description += cmd.description + "\n" }
        description
    end
end 

cmds = CommpositeCommand.new
cmds.add_command(CreateFile.new(Dir.pwd, 'Content of creating file'))
cmds.add_command(CopyFile.new(Dir.pwd, Dir.pwd + '/files'))
cmds.add_command(DeleteFile.new(Dir.pwd + '/files'))
cmds.execute
puts(cmds.description) #this show flow of app and states




#Prevent Abusing

#for just delete a file
File.delete(path)