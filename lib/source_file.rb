require "source_file_char"

class SourceFile

    attr_accessor :source_chars

    def initialize(source_text)
        @source_text  = source_text.split(//)
        @source_chars = []
        
        line_counter = 1
        pos = 1
        @source_text.each do |char|
            if char == "\n"
                line_counter += 1
                pos = 0 #Newline does not count as position.
            end
            new_char = SourceFileChar.new(char,line_counter,pos)
            pos += 1
            @source_chars.push(new_char)
        end
    end
    
    def show_source_chars
        puts "\n"
        @source_chars.each do |char|
            puts "Value: #{char.value} Line: #{char.line_num} Position: #{char.pos}"
        end
    end
end