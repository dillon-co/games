class Gear
  attr_reader :chainring, :cog, :rim, :tire
  def initialize(chainring, cog, rim, tire)
    @chainring = chainring
    @cog = cog
    @rim = rim
    @tire = tire
  end

  def ratio
    @chainring / cog.to_f
  end  

  def gear_inches
    # tire goes around rim twice for diameter
    ratio * (@rim + (@tire * 2))
  end
end


# Making it user friendly :)
puts "chainring size?"
chainring_size = gets.chomp.to_f
puts "cog size?"
cog_size = gets.chomp.to_f
puts "rim size?"
rim_size = gets.chomp.to_f
puts "tire size?"
tire_size = gets.chomp.to_f

gear =  Gear.new(chainring_size, cog_size, rim_size, tire_size)

puts "The ratio with regard to the wheels is #{gear.gear_inches}"
sleep 2
puts "\nThe ratio of gears is #{gear.ratio}"

    
