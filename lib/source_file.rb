class SourceFile
    attr_accessor :total_lines, :lines
    def initialize(total_lines, lines)
        @total_lines = total_lines
        @lines = lines
    end
end 
