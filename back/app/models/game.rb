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
	
	def get_games
		g = Game.find( :all, :select => 'uuid, map_uuid')
	end
end
