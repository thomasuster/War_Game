require 'Location.rb'
require 'Sector.rb'
require 'Hexagon_grid.rb'
require "rexml/document"
include REXML

class Map < Hexagon_grid
	attr_accessor :map
	
	def initialize()
		map = Hash.new
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
			l = Location.new(sector.attributes["x"], sector.attributes["y"])
			s = Sector.new(sector.text, l)
			map[l.to_s] = s
		end
	end
	
	#Returns a Hash of available moves
	def available_moves(location, distance)
		moves = Hash.new
		_available_moves(location, distance, moves);
		
		location_moves = Hash.new
		location_moves.each do |l|
			a = Location.un_pickle(l);
			location_moves[l.to_s] = Location.new(a[0], a[1]);
		end
		return location_moves;
	end
	
	#Helper function, Returns a Hash of available moves
	def _available_moves(location, distance, moves)
		if (distance < 0)
			return;
		
		#calc
		if (map[location.to_s].get_name() == "empty")
			return;
		var sector:Sector = map[location.x][location.y];
		var difficulty:int = int(Sector.sector_stats[sector.get_name()]["infantry_moves"]);
		var new_distance:int = new int(distance-difficulty);
		
		//Special unmovable case
		if (difficulty == -1)
			return;
		
		moves[String(location)] = distance;
		
		var circle:Array = get_circle(location, 1);
		for each (var l:Location in circle)
		{
			if (moves[String(l)] == null)
			{
				_available_moves(l, new_distance, moves);
			}
			else if (moves[String(l)] != null && moves[String(l)] < new_distance)
			{
				delete moves[String(l)];
				_available_moves(l, new_distance, moves);
			}
		}
	end
end