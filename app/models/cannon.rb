class Cannon < ActiveRecord::Base

	belongs_to :ship
	
	def fire
		result = []
		for i in 0..self.dice
			result << 1+ Random.rand(6)
		end
		return result
	end
end
