require "box"

class Parser
    
    attr_accessor :boxes

    def initialize()
        @boxes = [] 
    end

    def strip_white_space(source_file_line)
        source_file_line.text.delete!(" ")
        source_file_line.text.delete!("\t")
        return source_file_line
    end

    def scan_brackets(line)
        text = line.text
        position = 0
        text.each_char do |c|
            position += 1
            if c == "["
                box = Box.new(position,line.line_number)
                @boxes.push(box) 
            end
        end
    end
end
