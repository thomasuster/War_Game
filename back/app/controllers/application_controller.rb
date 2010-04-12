# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
	before_filter :authorize , :except => [:login, :home]
	
	helper :all # include all helpers, all the time
	#protect_from_forgery # See ActionController::RequestForgeryProtection for details
	protect_from_forgery

	# Scrub sensitive parameters from your log
	# filter_parameter_logging :password
	protected
	def authorize
		unless User.find_by_uuid(session[:user_uuid])
		  flash[:notice] = "Please log in"
		  redirect_to :controller => 'user', :action => 'login'
		end
	end
	
	public
	def is_admin
		unless (User.find_by_uuid(session[:user_uuid]) && User.find_by_uuid(session[:user_uuid]).email == "thomasuster@gmail.com")
				flash[:notice] = "If you're an admin, please login."
				redirect_to :controller => 'user', :action => 'login'
		end
	end
	
	#Launches the Flash instance
	def play
		print "\nHello world!!!!!!!!!!!!!!!!!!!!!!\n"
		@game = Game.get_game(params[:game_uuid])
		
	end
end
