class Sector < Board_object
	attr_accessor :sector_name
	
	def initialize(sector_name, location)
		super(location)
		@sector_name = sector_name
	end
end