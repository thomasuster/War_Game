require 'War_game/Location'
require 'War_game/Unit'

module War_game
	class Board
		attr_accessor :map
		attr_accessor :units
		
		def initialize(map, units)
			@map = map
			@units = units
			#Get stuffgame_uuid
		end
	end
end