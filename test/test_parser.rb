require "test_r_bracket"
require "parser"
require "source_file_line"

class TestParser < Minitest::Test

    def setup
        @parser = Parser.new()
    end

    def test_parser_strip_white_space
        source_file_line = SourceFileLine.new(1,"line with	spaces")
        striped_line = @parser.strip_white_space(source_file_line)
        assert_equal "linewithspaces", striped_line.text
    end

    def test_parser_count_boxes
        test_string = "[foo[bar]]"
        assert_equal 2, @parser.count_boxes(test_string)
        bad_test_string = "[[[]"
        assert_equal false, @parser.count_boxes(bad_test_string)
    end

    def test_parser_extract_boxes
        test_string = "[foo[bar] [baz]]"
        boxes = @parser.extract_boxes(test_string,3)
        assert_equal ["[bar]","[baz]","[foo1 2]"], boxes
    end

    def test_parse_box
        test_box = " number : (15) "
        test_box_tokens = @parser.parse_box(test_box)
        assert_equal [{name:"number",value:15}], test_box_tokens
    end

    def test_parser_find_box
        @parser.boxes = [Box.new(1,1),Box.new(1,4)]
        box = @parser.find_box(10005)
        assert_equal 10005, box.id
    end

    def test_parser_scan_brackets
        source_line_one = SourceFileLine.new(1,"[[var:[val")
        source_line_two = SourceFileLine.new(2,"]] [ var: val ]]")
        @parser.scan_brackets(source_line_one)
        @parser.scan_brackets(source_line_two)
        boxes = @parser.boxes 
        assert_equal 4, boxes.length
        assert_equal 7, boxes[2].position
    end
end
