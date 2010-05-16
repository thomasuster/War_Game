class Game < ActiveRecord::Base
	include UUIDHelper
	#validates_presence_of :turn_speed
	#validates_presence_of :map

	def setup (game)
		# #@height = hgt
		# #@width = wdth
		# flash[:notice] = "hello world"
		#super.initialize(game)
		require 'Time'
		t = Time.utc(nil,nil,days,hours,minutes,nil)
		@turn_speed = t
	end
	
	# Returns basic game information
	def self.get_game(uuid)
		g = Game.find( :first, :select => 'uuid, name, map_uuid', :conditions => {:uuid => uuid})
	end
	
	# Returns specific game information
	def self.get_current_map(uuid)
		g = Game.find( :first, :select => 'current_map', :conditions => {:uuid => uuid})
	end
	
	# Returns basic game information
	def self.get_games()
		g = Game.find( :all, :select => 'uuid, name, map_uuid')
	end
	
end
