class League

  attr_reader :calculator, :teams

  def initialize(args={})
    @teams = args.fetch(:teams, [])
    @calculator = args.fetch(:calculator) { PointsCalculator.new }
  end

  def standings
  	team_standing_sorted = teams.sort_by { |team| calculator.points_for_team(team) }
  	team_standing_sorted.reverse
  end

  def playoff_teams
  	midpoint = standings.length / 2
  	top_teams = standings[0...midpoint]
  end

  def position_for(name)
  	# # p standings.find_index(name)
  	# position = 0
  	# index = 0
  	# self.standings.each do |team|
  	# 	puts "this is the team *******"
  	# 	p team.name
  	# 	if team.name == name
  	# 		# p team.name
  	# 		p position = index + 1
  	# 	end
  	# 	index +=1
  	# end
  	# position 
  	team_names = []
  	self.standings.each do |team|
  		team_names << team.name
  	end
  	team_names.find_index(name) + 1
  end


end

