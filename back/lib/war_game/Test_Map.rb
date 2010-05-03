require "Location"
require "Map"
require "test/unit"
 
class Test_Map < Test::Unit::TestCase

	def test_gload_xml
		map = Map.new
		map.load_xml("../../public/front/maps/river.xml")
		
		# l = Location.new(0,0)
		# h = Hexagon_grid.new()
		# #h.get_circle(l,1).each{|e| p e}
		# assert_equal(7, h.get_circle(l,1).count)
		# assert_equal(19, h.get_circle(l,2).count)
		# assert_equal(19, h.get_circle(l,2).count)
		# assert_equal(37, h.get_circle(l,3).count)
	end

end