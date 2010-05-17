require 'War_game/Location'
require 'War_game/Unit'

module War_game
	class Units
		attr_accessor :units
		
		def initialize()
			@units = Hash.new
		end
		
		#Loads the units from given xml string or file
		def load_units(doc)
			doc = Document.new doc
			doc.elements.each("units/unit") do |unit|
				l = Location.new(sector.attributes["x"].to_i, sector.attributes["y"].to_i)
				color = unit.attributes["color"]
				type = unit.text
				make_unit(l, type, color);
			end
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