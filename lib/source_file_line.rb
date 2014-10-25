class SourceFileLine
    attr_accessor :line_number, :line_text
    def initialize(line_number, line_text)
        @line_number = line_number
        @line_text = line_text
    end
end
