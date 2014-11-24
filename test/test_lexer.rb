require "test_r_bracket"
require "lexer"
require "source_file"

class TestLexer < Minitest::Test

    def test_tokenize_strings
        source_file = SourceFile.new("[ foo : \"bar\"]")
        lexer = Lexer.new(source_file)
        lexer.tokenize_strings()
        char_status = source_file.source_chars[9].in_token?
        assert_equal true, char_status
    end
end