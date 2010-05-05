require 'War_game/Location.rb'

module War_game
	class Hexagon_grid
		attr_accessor :grid
		
		def initialize()
			
		end
		
		def distance(location_a, location_b)
			delta_x = (location_a.x - location_b.x).abs
			delta_y = (location_a.y - location_b.y).abs
			
			if location_a.x < location_b.x
				if location_a.y % 2 != 0 && location_b.y % 2 == 0
					delta_x-=1
				end
			elsif (location_a.x > location_b.x)
				if location_a.y % 2 == 0 && location_b.y % 2 != 0
					delta_x-=1
				end
			end
			
			#diagonal travel
			possible_x_traveled = (delta_y / 2.0).floor
			
			if delta_x > possible_x_traveled
				delta_x -= possible_x_traveled
			else
				delta_x = 0
			end
			
			return (delta_y + delta_x)
		end
		
		# Returns an array of locations for a circle.
		def get_circle(location, r)
			startY = location.y - r
			
			startX = 0
			endX = 0
			if startY % 2 == 0
				startX = location.x - (r / 2.0).floor
				endX = location.x + r;
			else
				startX = location.x - (r / 2.0).floor
				endX = location.x + r;
				if r % 2 == 0
					startX+=1; endX+=1;
				end
			end	
			
			endY = location.y + r;
			circle_width = 2 * r + 1;
			delta_y_odd = -1;
			delta_y_even = -1;
			offset = 0;
			circle = Array.new;
			for y in Range.new(startY, endY)
				length = circle_width - (y - location.y).abs;
				
				if (y % 2 == 0)
					if (delta_y_even == -1)
						delta_y_even = (y - location.y).abs;
					end
					offset = ((y - location.y).abs - delta_y_even) / 2;
					
					if ((location.y - r) % 2 != 0)
						offset-=1;
					end
				else
					if (delta_y_odd == -1)
						delta_y_odd = (y - location.y).abs;
					end
					offset =  (((y - location.y).abs - delta_y_odd) / 2.0).floor - 1;
				end
				
				start = startX + offset;
				#trace("y = " + y + "location = " + location.y + " : " + length);
				
				s = "";
				for x in Range.new(start, start + length - 1)
					s += x.to_s + " ";
							circle.push(Location.new(x,y));
				end
				#trace(s);
			end
			return circle;
		end
	end
end