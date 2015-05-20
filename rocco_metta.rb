class Player
  attr_accessor :x, :y
  def initialize
    @x = 12
    @y = 2
    $player = self
    instance_variables.each do |attribute|
      method = attribute.to_s[1..attribute.to_s.length]
      self.class.send(:define_singleton_method, method) do
        $player.send(method)
      end
    end
  end
  
  def self.coords
    {x: x, y: y}
  end

end            

Player.new

# Player.x = 4
puts Player.x
puts Player.y
puts Player.coords