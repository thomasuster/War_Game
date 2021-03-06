require "War_game/Location"
require "War_game/Unit"
require "test/unit"

module War_game
	class Test_Sector < Test::Unit::TestCase

		def test_sector_stats
			unit_name = "engineer"
			location = Location.new(0,0)
			unit = Unit.new(unit_name, "red", location, 5)
			p unit.get_name
			p unit.get_number
			p unit.get_type
			p unit.get_tier
			p unit.get_weapon
			p unit.get_range
			p unit.get_optimum_range
			p unit.get_bullet_defense
			p unit.get_shell_defense
			p unit.get_moves
		end

	end
end