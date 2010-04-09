class Game < ActiveRecord::Base
	include UUIDHelper
	validates_presence_of :turn_speed
	#validates_presence_of :map
	
	
	
	# def initialize (game)
		# #@height = hgt
		# #@width = wdth
		# flash[:notice] = "hello world"
		# super.initialize(game)
	# end
end
