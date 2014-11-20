require "test_r_bracket"
require "source_file_char"

class TestSourceChar < Minitest::Test

    def setup
        @char = SourceFileChar.new("c",5,5)
    end
    
    def test_source_file_char_create
        assert_equal 5, @char.line_num
        assert_equal 5, @char.pos
    end
    
    def test_source_file_char_in_token?
        @char.in_token = true
        assert_equal true, @char.in_token?
    end
    
    def teardown
        @char = nil
    end
end