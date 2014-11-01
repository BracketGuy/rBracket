class Parser

    def initialize()
        #puts "HELLO!"
    end

    def strip_white_space(source_file_line)
        source_file_line.line_text.delete!(" ")
        source_file_line.line_text.delete!("\t")
        return source_file_line
    end
end
