class SourceFile
    attr_accessor :total_lines, :lines
    def initialize(total_lines)
        @total_lines = total_lines
        @lines = []
    end

    def add_line(source_file_line)
        @lines.push(source_file_line)
    end
end 
