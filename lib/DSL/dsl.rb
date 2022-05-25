#The user understands his or her one area, his or her domain, but not the domain of programming.

# backup '/home/russ/documents'
# backup '/home/russ/music', file_name('*.mp3') & file_name('*.wav') backup '/home/russ/images', except(file_name('*.tmp'))
# to '/external_drive/backups'
# interval 60

class Backup
    include Singleton

    attr_accessor :backup_dir, :interval
    attr_reader :data_sources

    def initialize
        @backup_dir = '/opt/backup'
        @data_sources = []
        @interval = 60
    end

    def backup_files
        backup_folder = Time.new.ctime.tr(' :', '_')
        bakcup_path = File.join(@backup_dir, backup_folder)

        @data_sources.each { |source| source.backup(backupt_path) }
    end

    def run
        begin
            while true
                backup_files
                sleep (interval*60)
            end
        rescue DataMismatchError => e  
            puts e.message
            puts e.backtrace.inspect
        else
            puts "What if consition no run"
            retry
        ensure
            @data_sources = []
            @interval = 60
            backup_files
            sleep (interval*60)
        end
    end
end


class DataSource
    attr_reader :directory, :finder_expression

    def initialize
        @directory = directory
        @finder_expression = finder_expression
    end
end



#Pull DSl Together

class DataStructure
    def backup(dir, finder_expression=All.new)
        Backup.instance.data_sources << DataSource.new(dir, finder_expression)
    end
    def to(backup_dir)
        Backup.instance.backup_directory = backup_dir
    end
    def interval(minutes)
        Backup.instance.interval = minutes
    end
end

eval(File.read('bakcup.pr'))
Backup.instance.run





#Improve Packrat

class Backup
    attr_reader :backup_directory, :interval
    attr_accessor :data_sources
    def initialize
        @data_sources = []
        @backup_directory = '/backup'
        @interval = 60
        yield(self) if block_given?
        PackRat.instance.register_backup(self)
    end
    def backup(dir, finder_expression=All.new)
        @data_sources << DataSource.new(dir, finder_expression)
    end
    def to(backup_dir)
        @backup_directory = backup_dir
    end
    def interval(mins)
        @interval = mins
    end
    def run
        while true
            files_path = Time.now.ctime.tr(' :', '_')
            backup_path = File.join(@backup_directory, files_path)
            @data_sources.each { |source| source.backup(source) }
            sleep @interval * 60
        end
    end
end

class PackRat
    include ::Singleton
    def initialize
        @backups = []
    end
    def register_backup(backup)
        @backups << backup
    end
    def run
        threads = []
        @backups.each |backup|
            threads << Thread.new { backup.run }
        end
        threads.each { |thread| thread.join() }
    end
end

eval(File.read('backup.pr'))
PackRat.instance.run