require "War_game/Location"
require "War_game/Sector"
require "test/unit"

module War_game
	class Test_Sector < Test::Unit::TestCase

		def test_sector_stats
			sector_name = "grass"
			location = Location.new(0,0)
			sector = Sector.new(sector_name, location)
			# p sector.get_name
			# p sector.get_infantry_moves
			# p sector.get_vehicle_moves
			# p sector.get_attacking
			# p sector.get_defending
		end

	end
end