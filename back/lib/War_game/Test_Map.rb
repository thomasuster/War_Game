require 'War_game/Location'
require 'War_game/Map'
require 'test/unit'
	
module War_game
	class Test_Map < Test::Unit::TestCase

		def test_gload_xml
			map = Map.new
			map.load_xml("../public/front/maps/river.xml")
			location = Location.new(0,0)
			assert_equal(3, map.available_moves(location, 3).count)
			assert_equal(7, map.available_moves(location, 6).count)
		end

	end
end