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

    def find_box(id)
        if id == nil
            return false
        end
        found_box = nil
        @boxes.each do |box|
            if box.id == id
                found_box = box
            end
        end
        if found_box == nil
            return false
        else
            return found_box
        end
    end

    def scan_brackets(line)
        text = line.text
        position = 0
        text.each_char do |c|
            position += 1
            if c == "["
                box = Box.new(line.line_number,position)
                @boxes.push(box)
                @current_parent = box.id
            elsif c == "]"
                if @current_parent != nil
                    box = find_box(@current_parent)
                    #CLOSE BOX!
                    box.end_position = position
                    box.end_line = line.line_number
                    box.parent_id = @current_parent
                else
                    puts "Can't have a closing bracket before any opening bracket!"
                end
            end
        end
    end
end
