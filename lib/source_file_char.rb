class SourceFileChar

    attr_accessor :value, :line_num, :pos, :in_token

    def initialize(value,line_num,pos)
        @value     = value
        @line_num  = line_num
        @pos       = pos
        @in_token  = false
    end
    
    def in_token?
        @in_token
    end
end