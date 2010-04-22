class FrontController < ApplicationController
	protect_from_forgery :except => :save
	
	#Launches the Flash instance
	def play
		@game = Game.get_game(params[:game_uuid])
	end
	
	def save
		#@data = request.env['RAW_POST_DATA']
		@data = params
		print "\n\n\n\n\n"
		print params["map_name"] + "\n"
		print params["num_players"]
		render :layout => false
	end
end
