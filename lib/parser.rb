require "box"

class Parser
    
    attr_accessor :boxes, :current_parent

    def initialize()
        @boxes = []
        @current_parent = nil
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
                if @current_parent != nil
                box = Box.new(line.line_number,position)
                @boxes.push(box)
                @current_parent = box.id
            elsif c == "]"
                if @current_parent != nil
                    @boxes.each do |box|
                        if box.id == @current_parent
                            #CLOSE BOX!
                            box.end_position = position
                            box.end_line = line.line_number
                            box.parent_id = @current_parent
                        end
                    end 
                    puts @current_parent
                else
                    puts "Can't have a closing bracket before any opening bracket!"
                end
            end
        end
    end
end
