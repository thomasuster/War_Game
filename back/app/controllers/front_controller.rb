class FrontController < ApplicationController
	#protect_from_forgery :except => :save
	
	#Launches the Flash instance
	def play
		@game = Game.get_game(params[:game_uuid])
	end	
	
	def turn
		require 'War_game/Map'
		require 'War_game/Location'
		map = War_game::Map.new
		g = Game.get_game(params[:game_uuid])
		m = Map.get_map_data(g[:map_uuid])
		map.load_map(m[:data])
		location = War_game::Location.new(0,0)
		@data = (map.available_moves(location, 3).count == 3)
		
		render :layout => false
	end
	
	def get_map
		g = Game.get_game(params[:game_uuid])
		m = Map.get_map_data(g[:map_uuid])
		@data = m[:data]
		render :layout => false
	end
	
	def save
		#@data = request.env['RAW_POST_DATA']
		#@data = params
		params[:map] = Hash.new
		params[:map][:name] = params["name"]
		params[:map][:players] = params["players"]
		params[:map][:data] = params["data"]
		
		if true
			@map = Map.new(params[:map])
			
			if @map.save
				@response = "Map added to database.";
			else
				@response = "Map failed to be added to database.";
			end
		end
		
		#@response = "Map added to database.";
		#@response = params["name"];
		#print "\n\n\n\n\n"
		#print params["map_name"] + "\n"
		#print params["num_players"]
		render :layout => false
		
	end
end
