require "box"

class Parser
    
    attr_accessor :boxes, :current_parent

    def initialize()
        @boxes = []
        @current_parent = nil
        @previous = :open
        @depth = 0
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

    def count_boxes(source)
        opens = source.count("[")
        closes = source.count("]")
        if opens == closes
            return opens
        else
            return false
        end 
    end

    def extract_boxes(source,box_count)
        source_array = source.split(//)
        working_array = []
        box_stack = []
        pos = 0
        offset = 0
        box_status = nil

        box_count.times do
            found_boxes = 0
            source_array.length.times do
                char = source_array.shift() 
                working_array.push(char)
                pos += 1
                offset += 1
                if char == "["
                    box_status = :open
                    offset = 1 
                elsif char == "]" && box_status == :open
                    box_status = :closed
                    if found_boxes == 0
                        box = working_array.pop(offset)
                        box_stack.push(box.join(""))
                        box_id = box_stack.length
                        working_array.push(box_id)
                        found_boxes += 1
                    end
                elsif char == "]"
                    box_status = :closed
                end
                if source_array == []
                    source_array = working_array
                    pos = 0
                    offset = 0
                end
            end
        end
        return box_stack
    end

    def parse_box(box_text)
        #code to handle commas and newlines goes here
        assigns = box_text.count(":")
        box_val = []
        if assigns == 1
            halves = box_text.split(':')
            halves.each do |half|
                half.strip!
            end
            if halves[1].start_with?("(")
                # More code to eval math containers goes here. For now, we just
                # trim parens off.
                halves[1].delete!("(")
                halves[1].delete!(")")
                halves[1] = halves[1].to_i
            end
            variable = {name:halves[0],value:halves[1]}
            box_val.push(variable)          
        else
            # Some standard way of handling syntax errors and displaying their
            # location in the line.
        end
        return box_val
    end

    def scan_brackets(line)
        text = line.text
        position = 0
        text.each_char do |c|
            position += 1
            if c == "["
                box = Box.new(line.line_number,position)
                unless @current_parent.nil?
                    box.parent_id = @current_parent
                    parent_box = find_box(@current_parent)
                    parent_box.total_children += 1
                    parent_box.open_children += 1
                else
                    box.parent_id = 10000
                end
                @boxes.push(box)
                @current_parent = box.id
                if @previous == :open
                    @depth += 1
                end
                @previous = :open
                #puts "line: #{line.line_number} id: #{box.id} depth: #{@depth}"
            elsif c == "]"
                if @current_parent != nil
                    box = find_box(@current_parent)
                    box.end_position = position
                    box.end_line = line.line_number
                    unless box.open_children == 0
                        box.open_children -= 1
                    end
                    box.close
                    @current_parent = box.parent_id
                else
                    puts "Can't have a closing bracket before any opening bracket!"
                end
                if @previous == :close
                    @depth -= 1
                end
                @previous = :close
                #puts "line: #{line.line_number} id: #{box.id} depth: #{@depth}"
            end
        end
    end
end
