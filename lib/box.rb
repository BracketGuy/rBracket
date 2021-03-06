class Box
    attr_accessor :line_number, :end_line, :position, :end_position,
                  :closed, :total_children, :open_children, :id,
                  :parent_id
    def initialize(line_number,position)
        @line_number = line_number
        @end_line = nil
        @position = position
        @end_position = nil
        @closed = false
        @open_children = 0
        @total_children = 0
        @id = 10000 + line_number + position
        @parent_id = nil
    end

    def close
        if @end_position != nil && @end_line != nil
            @closed = true
        end
    end

    def closed?
        if @closed == true
            return true
        else
            return false
        end
    end
end
