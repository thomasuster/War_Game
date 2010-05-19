require 'War_game/Location'
require 'War_game/Sector'
require 'War_game/Hexagon_grid'
require 'War_game/Combat'
require 'War_game/Map'
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
			
			#Processing combat
			tapped_units = Hash.new
			
			xml.elements.each("turn/combat") do |combat|
				attacker_l = Location.new(combat.elements["attacker"].attributes["x"], combat.elements["attacker"].attributes["y"])
				defender_l = Location.new(combat.elements["defender"].attributes["x"], combat.elements["defender"].attributes["y"])
				
				attacker = @units.get_unit(attacker_l)
				defender = @units.get_unit(defender_l)
				
				if(attacker != nil)
					if(tapped_units[attacker.location.to_s] == nil)
						if(Map.distance(attacker.location, defender.location) <= attacker.get_range)
							p "legal attack"
							
							attacker_terrain = @map.get_sector(attacker.location);
							defender_terrain = @map.get_sector(defender.location);
				
							combat = Combat.new(attacker, defender)
							destroyed = combat.engage(Map.distance(attacker.location, defender.location), 
							attacker_terrain.get_attacking(), attacker_terrain.get_defending(),
							defender_terrain.get_attacking(), defender_terrain.get_defending())
					
							tapped_units[attacker.location.to_s] = attacker
							
							#Remove destroyed units
							#destroyed.each do |d|
							#		@units.destroy_unit(d.location)
							#end
						else
							p "illegal attack"
						end
					else
						p "already attacked this turn"
					end
				else
					p "no such unit to intiate attack"
				end
			end
			
			return @units.export_units
			
		end
	end
end