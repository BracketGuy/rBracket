class SourceFileLine
    attr_accessor :line_number, :text
    def initialize(line_number, text)
        @line_number = line_number
        @text = text
    end
end
