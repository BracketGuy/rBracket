require_relative "source_file"
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
        source_file = SourceFile.new(count)
        char_buffer = []
        line_counter = 0
        file.each_char do |c|
            if c == "\n"
                ++line_counter
                source_file_line = SourceFileLine.new(line_counter,char_buffer)
                source_file.add_line(source_file_line)
                char_buffer = []
            else
                char_buffer.push(c)
            end
        end
        puts source_file.lines
        puts "Processed #{count} lines."
    end
end
