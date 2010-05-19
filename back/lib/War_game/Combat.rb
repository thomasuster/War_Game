require 'War_game/Location'
require 'War_game/Weapon'

module War_game
	class Combat
		attr_accessor :attacker
		attr_accessor :defender
		
		def initialize(attacker, defender)
			@attacker = attacker
			@defender = defender
		end
		
		# Returns Array of units destroyed
		# param	range
		# param	attacker_mult_damage
		# param	attacker_mult_defense
		# param	defender_mult_damage
		# param	defender_mult_defense
		# return
		def engage(range, 
		attacker_mult_damage, attacker_mult_defense,
		defender_mult_damage, defender_mult_defense)
			destroyed = Array.new
			a_damage = damage(@attacker, range, attacker_mult_damage)
			d_damage = damage(@defender, range, attacker_mult_damage)
			a_defense = defense(@attacker, attacker_mult_defense)
			d_defense = defense(@defender, defender_mult_defense)
			
			if (a_damage-d_defense > 0)
				@defender.number -= a_damage-d_defense
				if (@defender.number <= 0)
					destroyed.push(@defender)
				end
			end
				
			if (d_damage-a_defense > 0)
				p "I took #{d_damage-a_defense} damage"
				@attacker.number -= d_damage-a_defense;
				if (@attacker.number <= 0)
					destroyed.push(@attacker)
				end
			end
			
			return destroyed;
		end
		
		# Unit's raw damage
		def damage(unit, range, attack_multiplier)
			weapon = Weapon.new(unit.get_weapon)
			if (range > unit.get_range)
				return 0
			else 	
				#return (unit.get_number() * attack_multiplier) * 1/(Math.abs(range - unit.get_optimum_range())+1) * (weapon.get_power() * weapon.get_number());
				return unit.get_number
			end
		end
		
		# Unit's raw defense
		def defense(unit, defense_multiplier)
			return (unit.get_number() * defense_multiplier)
		end
	end
end