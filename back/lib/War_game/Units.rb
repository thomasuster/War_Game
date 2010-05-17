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
				l = Location.new(unit.attributes["x"].to_i, unit.attributes["y"].to_i)
				color = unit.attributes["color"]
				type = unit.text
				make_unit(l, type, color);
			end
		end
		
		#Returns XML of the all current units
		def export_units()
			s = "<units>\n"
			@units.each_value do |unit|
				s += "\t<unit x='" + unit.location.x.to_s + "' y='" + unit.location.y.to_s + "' number='" + unit.get_number.to_s + "' color='" + unit.get_color + "'>" + unit.get_name + "</unit>\n";
			end
			s += "</units>\n"
			return s
		end
		
		def make_unit(location, type, color)
			unit = Unit.new(type, color, location)
			units[location.to_s] = unit
		end
		
		def move_unit(unit, location)
			units[location.to_s] = unit
			p "deleting #{unit.location.to_s} " 
			p "adding #{location.to_s} " 
			units.delete(unit.location.to_s) { |el| "#{el} not found" }
			unit.location = location
		end
		
		def destroy_unit(location)
			units.delete(location.to_s)
		end
		
		def get_unit(location)
			units[location.to_s]
		end
		
		
	end
end