require 'Location.rb'
require 'Sector.rb'
require 'Hexagon_grid.rb'
require "rexml/document"
include REXML

class Map < Hexagon_grid
	attr_accessor :map
	
	def initialize()
		@map = Hash.new
	end
	
	#Loads the map xml file, calls load_map with files contents
	def load_xml(xml_url)
	
		file = File.new(xml_url)
		doc = Document.new file
		load_map(doc)
		# file = File.open(xml_url, "r")
		# xml = ""
		# file.each_line do |line|
			# xml += line
		# end
		# load_map(xml)
		# file.close
	end
	
	#Loads the map from given xml
	def load_map(doc) 
		original_map = Hash.new;
		
		doc.elements.each("map/s") do |sector|
			#Make Sector
			l = Location.new(sector.attributes["x"].to_i, sector.attributes["y"].to_i)
			s = Sector.new(sector.text, l)
			@map[l.to_s] = s
		end
	end
	
	#Returns a Hash of available moves
	def available_moves(location, distance)
		moves = Hash.new
		_available_moves(location, distance, moves)
		
		location_moves = Hash.new
		moves.each_key do |l|
			a = Location.un_pickle(l.to_s);
			location_moves[l.to_s] = Location.new(a[0], a[1]);
		end
		return location_moves;
	end
	
	#Helper function, Returns a Hash of available moves
	def _available_moves(location, distance, moves)
		return if (distance < 0)
		
		#calc
		return if (@map[location.to_s].nil?)
		#return if (@map[location.to_s].get_name() == "empty")
		
		sector = @map[location.to_s];
		difficulty = sector.get_infantry_moves()
		new_distance = distance-difficulty.to_i;
		
		#Special unmovable case
		return if (difficulty == -1)
		
		moves[location.to_s] = distance;
		
		circle = get_circle(location, 1)
		circle.each do |l|
			if !moves.has_key?(l.to_s)
				_available_moves(l, new_distance, moves);
			elsif (moves.has_key?(l.to_s) && moves[l.to_s] < new_distance)
				moves.delete(l.to_s);
				_available_moves(l, new_distance, moves)
			end
		end
	end
end