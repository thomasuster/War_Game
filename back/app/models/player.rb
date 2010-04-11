class Player < ActiveRecord::Base
	 include UUIDHelper
	 
	 # Returns basic game information
	def get_players(user_uuid)
		Player.find( :all, :select => 'user_uuid, game_uuid', :conditions => {:user_uuid => user_uuid})		
	end
end
