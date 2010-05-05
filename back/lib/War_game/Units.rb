require 'War_game/Location'
require 'War_game/Unit'

module War_game
	class Units
		attr_accessor :units
		
		def initialize()
			@units = Hash.new
		end
		
		def make_unit(location, type, color)
			unit = Unit.new(type, color)
			units[location.to_s] = unit
		end
		
		def move_unit(unit, location)
			#trace(location.x + " | " + location.y);
			units[location.to_s] = unit
			units.delete(unit.location)
			unit.location = location
		end
		
		def destroy_unit(location)
			units.delete(location.to_s)
		end
		
		def get_unit(location)
			units[location]
		end
		
		
	end
end