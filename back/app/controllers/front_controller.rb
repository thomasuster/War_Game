class FrontController < ApplicationController
	#Launches the Flash instance
	def play
		@game = Game.get_game(params[:game_uuid])
	end
end
