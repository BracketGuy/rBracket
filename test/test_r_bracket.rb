gem "minitest"
require "minitest/autorun"
require "r_bracket"
require "source_file"

class TestRBracket < Minitest::Test
    def test_source_file_create
        mock_lines = ["line 1","line 2"]
        test_source_file = SourceFile.new(2,mock_lines)
        assert_equal test_source_file.total_lines, 2
        assert_equal test_source_file.lines, ["line 1","line 2"] 
    end
end
