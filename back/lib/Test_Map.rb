module War_game
	require 'Location.rb'
	require 'Map.rb'
	require 'test/unit'
	 
	class Test_Map < Test::Unit::TestCase

		def test_gload_xml
			map = Map.new
			map.load_xml("../../public/front/maps/river.xml")
			location = Location.new(0,0)
			assert_equal(3, map.available_moves(location, 3).count)
		end

	end
end