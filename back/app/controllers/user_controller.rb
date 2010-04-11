class UserController < ApplicationController

	def login
	
		if request.post?
			user = User.authenticate(params[:email], params[:password])
			if user
				session[:user_uuid] = user.uuid
				redirect_to(:action => "index")
			else
				flash.now[:notice] = "Invalid user/password combination"
			end
		end
	end
	
	# Returns the game uuid, game name and map name	for all of this users games
	def index
		game = Game.new
		games = game.get_games(session[:user_uuid])
		@games = game.preview_games(games)
	end

	# Returns the game uuid, game name and map name	
	def show_games
		game = Game.new
		player = Player.new
		players = player.get_players
		
		players.each do |p|
		
		end
		
		
		@games = game.preview_games(games)
	end
	
	# Returns hash of preview information of games, getting map information
	# * games: array of Games
	def preview_games(games)
		h = {}
		games.each do |g|
			map = Map.new
			m = map.get_map(g[:map_uuid])
			h[g.uuid] = {:game_name => g.name, :map_name => m.name}
		end
		return h
	end
	
	
	
	# Trys to join a game
	def join
		params[:player] = {}
		params[:player][:game_uuid] = params[:game_uuid]
		params[:player][:user_uuid] = session[:user_uuid]
	
		@player = Player.new(params[:player])

		respond_to do |format|
			if @player.save
				flash[:notice] = 'You joined the game!'
				format.html { redirect_to(:action => "index") }
				format.xml  { render :xml => @player, :status => :created, :location => @player }
			else
				flash[:notice] = 'You didn\'t join the game.'
				format.html { redirect_to(:action => "show_games") }
				format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
			end
		end
		
	end

	def logout
		session[:user_uuid] = nil
		flash[:notice] = "Logged out"
		redirect_to(:action => "login")
	end
	

	

end