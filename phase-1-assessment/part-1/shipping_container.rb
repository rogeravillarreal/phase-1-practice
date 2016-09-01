require_relative 'crate'

class ShippingContainer

	attr_accessor :destination, :crates, :max_weight, :max_crates
	# the shipping container is full when it hwas reached a weight capacity or crate capacity.

	def initialize(args={}) #input => Hash
		# how much weight can be added?
		# how many crates can be added?
		# is the container full?
		@destination = args[:destination]
		@crates = args[:crates]
		@max_weight = args[:max_weight]
		@max_crates = args[:max_crates]
		@crate_weights = []
	end

	def current_weight
		# weight starts at 0
		# @crates[0].weight => crate weight
		starting_weight = 0
		# when there is more than one create, add the total weight of the crates and return the total weight
		# find the weight of each crate and add to current weight.
		# iterate throught crates and push values to an array
		# add all values in array
		if @crates.count > 0
			@crates.each { |crate| @crate_weights << crate.weight}
			@crate_weights.inject(:+) #=> total weight
		else
			starting_weight
		end
	end

		def crates_count
			@crates.count
		end

		def add_crate(crate)
			if current_weight + crate.weight <= @max_weight
				@crates << crate
				true
			elsif 
				current_weight + crate.weight > @max_weight
				false
			elsif 
				crates_count <= @max_crates
				true
			else
				false
			end
				
		end

end
