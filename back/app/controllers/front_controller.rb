class FrontController < ApplicationController
	#Launches the Flash instance
	def play
		@game = Game.get_game(params[:game_uuid])
	end
	
	def save
		@data = request.env['RAW_POST_DATA']
		#print params.inspect
		render :layout => false
	end
end
