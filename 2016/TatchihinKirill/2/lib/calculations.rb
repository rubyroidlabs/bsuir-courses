module Calculations
	def calculate_labs(start_sem, end_sem, subjects)
		sum = 0
		subjects.each do |key,  value|
			sum += value[key]
		end
		totally_days = start_sem[1] * (end_sem[2] - start_sem[2]) * 30
		result = totally_days.to_f % sum
	end
end
