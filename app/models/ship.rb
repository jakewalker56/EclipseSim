class Ship < ActiveRecord::Base

	has_many :missiles
	has_many :cannons
	belongs_to :fleet

	def fire_cannons
		#return a hash of adjusted dice rolls and corresponding damage
		result = []
		# 6's are always represented as 1,000, 1's are represented as 0
		self.cannons.each do |cannon|
			shots = cannon.fire
			shots.each do |shot|
				if shot == 1
					result << { hit: 0, damage: cannon.power }
				elsif shot == 6
					result << { hit: 1000, damage: cannon.power }
				else
					result << { hit: shot + self.targetting, damage: cannon.power }
				end
			end
		end
		return result
	end
	def fire_missiles
		#return a hash of adjusted dice rolls and corresponding damage
		result = []
		# 6's are always represented as 1,000, 1's are represented as 0
		self.missiles.each do |missile|
			shots = missile.fire
			shots.each do |shot|
				if shot == 1
					result << { hit: 0, damage: missile.power }
				elsif shot == 6
					result << { hit: 1000, damage: missile.power }
				else
					result << { hit: shot + self.targetting, damage: missile.power }
				end
			end
		end
		return result
	end

end
