require "test_r_bracket"
require "source_file"

class TestSourceFile < Minitest::Test

    def test_source_file_create
        source_file = SourceFile.new("[ foo : \n [ bar ] ]")
        source_char = source_file.source_chars[2]
        assert_equal "f", source_char.value
        assert_equal 3, source_char.pos
        assert_equal 1, source_char.line_num
    end
end