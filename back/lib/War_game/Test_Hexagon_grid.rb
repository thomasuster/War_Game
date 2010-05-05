require "War_game/Location"
require "War_game/Hexagon_grid"
require "test/unit"

module War_game
	class Test_Hexagon_grid < Test::Unit::TestCase

		def test_get_circle
			l = Location.new(0,0)
			h = Hexagon_grid.new()
			#h.get_circle(l,1).each{|e| p e}
			assert_equal(7, h.get_circle(l,1).count)
			assert_equal(19, h.get_circle(l,2).count)
			assert_equal(19, h.get_circle(l,2).count)
			assert_equal(37, h.get_circle(l,3).count)
		end

	end
end