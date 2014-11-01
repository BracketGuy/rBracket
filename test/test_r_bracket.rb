gem "minitest"
require "minitest/autorun"
require "r_bracket"
require "source_file"
require "source_file_line"
require "parser"

class TestRBracket < Minitest::Test
    def test_source_file_create
        source_file = SourceFile.new(2)
        assert_equal 2, source_file.total_lines
    end

    def test_source_file_line_create
        source_file_line = SourceFileLine.new(2,"test line")
        assert_equal source_file_line.line_number, 2
        assert_equal "test line", source_file_line.line_text
    end

    def test_source_file_add_line
        source_file = SourceFile.new(1)
        source_file_line = SourceFileLine.new(1,"test line")
        source_file.add_line(source_file_line)
        assert_equal source_file_line, source_file.lines[0]
    end

    def test_parser_strip_white_space
        parser = Parser.new()
        source_file_line = SourceFileLine.new(1,"line with	spaces")
        striped_line = parser.strip_white_space(source_file_line)
        assert_equal "linewithspaces", striped_line.line_text
    end
end
