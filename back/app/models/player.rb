class Player < ActiveRecord::Base
	 include UUIDHelper
	 
	# Returns basic game information
	def self.get_game_uuids(user_uuid)
		Player.find( :all, :select => 'user_uuid, game_uuid', :conditions => {:user_uuid => user_uuid})		
	end
	
	# Returns the number of players
	def self.num_players(game_uuid)
		Player.count( :conditions => {:game_uuid => game_uuid} )
	end
	
	def join
	
	end
end
