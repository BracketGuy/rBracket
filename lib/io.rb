require_relative "source_file_line"

def handle_command_args
    if ARGV.length == 0
        puts "usage: bracket [filename]"
    elsif ARGV.length == 1
        return ARGV[0]
    end
end

def count_lines_in_file(file)
    count = file.readlines.length
    file.rewind
    return count
end

def read_in_file(filename)
    if filename.nil?
        return
    else
        begin
            file = File.open(filename,"r")
        rescue
            puts "Could not open file #{filename}. Make sure the file exists."
            return
        end
        count = count_lines_in_file(file)
        file.each_char do |c|
            puts "Got one!" if c == "\n"
        end
        puts "Processed #{count} lines."
    end
end
