class Player < ActiveRecord::Base
	include UUIDHelper
	 
	#I'm not alread in a game
	validates_uniqueness_of :user_uuid, :scope => [:game_uuid], :message => "You\'re already in that game"
	 
	# Returns basic game information
	def self.get_game_uuids(user_uuid)
		Player.find( :all, :select => 'user_uuid, game_uuid', :conditions => {:user_uuid => user_uuid})		
	end
	
	# Returns the number of players
	def self.num_players(game_uuid)
		Player.count( :conditions => {:game_uuid => game_uuid} )
	end
	
	# Gets the players
	def self.get_players(game_uuid)
		Player.find( :all, :select => 'user_uuid', :conditions => {:game_uuid => game_uuid})
	end
	
	def validate
		#If It's not full
		#game = Game.get_game(@game_uuid)
		#map = Map.get_map(game[:map_uuid])
		#num = Player.num_players(@game_uuid)
		#errors.add_to_base "Game is full" if num < map.players
	end

end
