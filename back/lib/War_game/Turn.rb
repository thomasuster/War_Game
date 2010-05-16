require 'War_game/Location'
require 'War_game/Sector.rb'
require 'War_game/Hexagon_grid.rb'
require "rexml/document"
include REXML

module War_game
	class Turn
		
		def initialize()
			
		end

		#Processes the Turn with the give xml
		def process_turn(xml)
			xml = Document.new xml
			#original_map = Hash.new;
			
			xml.elements.each("turn/move/move") do |move|
				#Get unit by starting location
				#See if ending is available
				#move
				
				
				#Make Sector
				#l = Location.new(sector.attributes["x"].to_i, sector.attributes["y"].to_i)
				#s = Sector.new(sector.text, l)
				#@map[l.to_s] = s
			end
		end
	end
end