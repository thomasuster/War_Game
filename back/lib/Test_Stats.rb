require "test/unit"
require "Stats"

 
class Test_Stats < Test::Unit::TestCase

	def test_process_xml
		stats = Stats.new("../../public/front/stats/sectors.xml")
	end

end