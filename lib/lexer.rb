class Lexer

    attr_accessor :source_file

    def initialize(source_file)
        @source_file = source_file
    end
    
    def tokenize_strings
        # Use string scanner to find quoted sections, mark them as tokens, and make copies of
        # the tokens for later use.
    end
end