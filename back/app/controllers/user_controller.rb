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
  
	def show_games
		#Returns the game uuid, game name and map name
		game = Game.new
		games = game.get_games

		h = {}

		games.each do |g|
			map = Map.new
			m = map.get_map(g[:map_uuid])
			h[g.uuid] = {:game_name => g.name, :map_name => m.name}
		end
		@games = h
	end
  
  
  
	def join

	end
  
  def logout
    session[:user_uuid] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end
  

  
  def index
    #@total_orders = Order.count
  end

end