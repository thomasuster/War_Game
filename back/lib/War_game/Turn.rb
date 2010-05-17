require 'War_game/Location'
require 'War_game/Sector.rb'
require 'War_game/Hexagon_grid.rb'
require "rexml/document"
include REXML

module War_game
	class Turn
		
		def initialize(map, units)
			@map = map
			@units = units
		end

		#Processes the Turn with the give xml
		def process_turn(xml)
			xml = Document.new xml
			
			#Processing moves
			moved_units = Hash.new
			xml.elements.each("turn/moves/move") do |move|
				start_l = Location.new(move.elements["start"].attributes["x"], move.elements["start"].attributes["y"])
				end_l = Location.new(move.elements["end"].attributes["x"], move.elements["end"].attributes["y"])
				
				unit = @units.get_unit(start_l)
				
				if(unit != nil)
					if(moved_units[unit.location.to_s] == nil)
						available_moves = @map.available_moves(unit.location, unit.get_moves)
						if(available_moves[end_l.to_s])
							p "legal move"
							@units.move_unit(unit, end_l)
							moved_units[unit.location.to_s] = unit
						else
							p "illegal move"
						end
					else
						p "already moved this unit this turn"
					end
				else
					p "no such unit to move"
				end
			end
			
			return @units.export_units
			#Processing combat
			
		end
	end
end