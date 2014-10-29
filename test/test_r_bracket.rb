gem "minitest"
require "minitest/autorun"
require "r_bracket"
require "source_file"
require "source_file_line"

class TestRBracket < Minitest::Test
    def test_source_file_create
        source_file = SourceFile.new(2)
        assert_equal source_file.total_lines, 2
    end

    def test_source_file_line_create
        source_file_line = SourceFileLine.new(2,"test line")
        assert_equal source_file_line.line_number, 2
        assert_equal source_file_line.line_text, "test line"
    end

    def test_source_file_add_line
        source_file = SourceFile.new(1)
        SourceFile.add_line(1,"test line")
    end
end
