class GenerateRatiosWorker
	
	@queue = :generate_ratios

	def self.perform
		Currency.where(default: false).each do |currency|
			Ratio.create({
			   currency_id: currency.id,
			   ratio: rand(0.0...5.0).round(3)
			})
			puts currency.id
		end
	end
end