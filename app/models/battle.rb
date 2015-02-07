class Battle < ActiveRecord::Base
	def is_hit(value)
		return value > 5
	end

	def is_alive(damage, hull)
		return damage <= hull
	end
	def check_alive
		temp_offense_alive = false
		temp_defense_alive = false
		@offense.ships.each do |ship|
			if is_alive(@offensive_ships[ship.id], ship.hull)
				temp_offense_alive = true
			end
		end
		@defense.ships.each do |ship|
			if is_alive(@defensive_ships[ship.id], ship.hull)
				temp_defense_alive = true
			end
		end
		if !temp_defense_alive
			@defense_alive = false
		end
		if !temp_offense_alive
			@offense_alive = false
		end
	end
	def assign_rolls_to_offense(rolls)
		rolls.each do |roll|
			@offense.ships.each do |ship|
				if is_hit(roll[:hit] - ship.shield)
					if is_alive(@offensive_ships[ship.id], ship.hull)
						#assign damage
						@offensive_ships[ship.id] += roll[:damage]
					end
				end
			end
		end
	end
	def assign_rolls_to_defense(rolls)
		rolls.each do |roll|
			@defense.ships.each do |ship|
				if is_hit(roll[:hit] - ship.shield)
					if is_alive(@defensive_ships[ship.id], ship.hull)
						#assign damage
						@defensive_ships[ship.id] += roll[:damage]
						break
					end
				end
			end
		end
	end
	def simulate
		result = {}
		iterations = 200
		winners = []
		@defense = Fleet.find(self.defense_id)
		@offense = Fleet.find(self.offense_id)
		for i in 0...iterations
			#create hash of ships and damage
			@offensive_ships = {}
			@defensive_ships = {}
			@defense.ships.each do |ship|
				@defensive_ships[ship.id] = 0
			end
			@offense.ships.each do |ship|
				@offensive_ships[ship.id] = 0
			end
			@offense_alive = true
			@defense_alive = true
			#time out in case battle ends in draw
			for i in 0...10
				#check for battle over
				check_alive()
				if !@offense_alive
					winners << :defense
					break
				elsif !@defense_alive
					winners << :offense
					break
				end

				max_init = [@offense.ships.max_by {|obj| obj.initiative }.initiative, @defense.ships.max_by {|obj| obj.initiative }.initiative].max
				if i == 0
					#fire missiles
					
					for k in 0..max_init
						j = max_init - k
						#have all defensive ships fire all cannons
						defensive_rolls = []
						@defense.ships.where(initiative: j).each do |ship|
							if is_alive(@defensive_ships[ship.id], ship.hull)
								ship.fire_missiles.each do |shot|
									defensive_rolls << shot
								end
							end
						end
						#assign rolls to enemy ships
						assign_rolls_to_offense(defensive_rolls)

						#have all offensive ships fire all cannons
						offensive_rolls = []
						@offense.ships.where(initiative: j).each do |ship|
							if is_alive(@offensive_ships[ship.id], ship.hull)
								ship.fire_missiles.each do |shot|
									offensive_rolls << shot
								end
							end
						end
						#assign rolls to enemy ships
						assign_rolls_to_defense(offensive_rolls)
					end
				end
				#find ships with highest initiative
				for k in 0..max_init
					j = max_init - k
					#have all defensive ships fire all cannons
					defensive_rolls = []
					@defense.ships.where(initiative: j).each do |ship|
						if is_alive(@defensive_ships[ship.id], ship.hull)
							ship.fire_cannons.each do |shot|
								defensive_rolls << shot
							end
						end
					end
					#assign rolls to enemy ships
					assign_rolls_to_offense(defensive_rolls)

					#have all offensive ships fire all cannons
					offensive_rolls = []
					@offense.ships.where(initiative: j).each do |ship|
						if is_alive(@offensive_ships[ship.id], ship.hull)
							ship.fire_cannons.each do |shot|
								offensive_rolls << shot
							end
						end
					end
					#assign rolls to enemy ships
					assign_rolls_to_defense(offensive_rolls)
				end
			end
		end
		offensive_wins = winners.select{ |val| val == :offense}.count
		defensive_wins = winners.select{ |val| val == :defense}.count

		result[:winner] = offensive_wins > defensive_wins ? "Offense" : "Defense"
		result[:win_percentage] = offensive_wins > defensive_wins ? 
			100.0 * offensive_wins/(offensive_wins + defensive_wins) : 
			100.0 * defensive_wins/(offensive_wins + defensive_wins)
		return result
	end
end
