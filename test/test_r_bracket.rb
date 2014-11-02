gem "minitest"
require "minitest/autorun"
require "r_bracket"
require "source_file"
require "source_file_line"
require "parser"
require "box"

class TestRBracket < Minitest::Test

    #SourceFile

    def test_source_file_create
        source_file = SourceFile.new(2)
        assert_equal 2, source_file.total_lines
    end

    def test_source_file_line_create
        source_file_line = SourceFileLine.new(2,"test line")
        assert_equal source_file_line.line_number, 2
        assert_equal "test line", source_file_line.text
    end

    def test_source_file_add_line
        source_file = SourceFile.new(1)
        source_file_line = SourceFileLine.new(1,"test line")
        source_file.add_line(source_file_line)
        assert_equal source_file_line, source_file.lines[0]
    end

    #Parser

    def test_parser_strip_white_space
        parser = Parser.new()
        source_file_line = SourceFileLine.new(1,"line with	spaces")
        striped_line = parser.strip_white_space(source_file_line)
        assert_equal "linewithspaces", striped_line.text
    end

    def test_parser_find_box
        parser = Parser.new()
        parser.boxes = [Box.new(1,1),Box.new(1,4)]
        box = parser.find_box(10005)
        assert_equal 10005, box.id
    end

    def test_parser_scan_brackets
        parser = Parser.new()
        source_line_one = SourceFileLine.new(1,"[var:[val")
        source_line_two = SourceFileLine.new(2,"]]")
        parser.scan_brackets(source_line_one)
        parser.scan_brackets(source_line_two)
        boxes = parser.boxes 
        assert_equal 2, boxes.length
        assert_equal 6, boxes[1].position
    end

    #Box

    def test_box_create
         box = Box.new(5,23)
         assert_equal 5, box.line_number
         assert_equal 23, box.position
    end

    def test_box_close
         box = Box.new(1,1)
         box.end_position = 5
         box.end_line = 1
         box.open_children = 0
         box.close()
         assert_equal true, box.closed?
    end
end
