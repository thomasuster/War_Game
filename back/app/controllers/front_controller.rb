class FrontController < ApplicationController
	#Launches the Flash instance
	def play
		@game = Game.get_game(params[:game_uuid])
	end
	
	def save
		print "\n\n OOOOOOOOOOOOOOOOOOOOOOOOOO \n"
		print params[:map].inspect
		print "\n OOOOOOOOOOOOOOOOOOOOOOOOOO n\n"
	end
end
