require "test_r_bracket"
require "box"

class TestBox < Minitest::Test
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