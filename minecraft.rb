# w7d1 Ruby OOP Breakout in-class 
# oop for minecraft objects
class World 
  attr_reader :name
  def initialize name
    @name = name
  end
end

# Monster class
class Mod 

  attr_reader :name, :health, :world, :type
  attr_writer :name, :health

  def initialize name, health, world
    @name = name
    @health = health
    @world = world
  end

  def attack opponent
    puts "Attack opponent!"
  end

  def getWorld
    'The mod origins from ' + @world.name
  end

  def save
    sql = "INSERT INTO monsters (name, health)"
    puts sql
  end

end

# Inheritance
class TeleportType < Mod
  # attr_reader :type

  def initialize name, health, world
    super name, health, world
    @type = 'teleport'
  end

  def attack opponent
    puts "#{@name} attack #{opponent.name}!"
    opponent.health - 10
  end
end

class ShootingType < Mod
  # attr_reader :type
  def initialize name, health, world
    super name, health, world
    @type = 'shooting'
  end

  def attack opponent
    puts "#{@name} attack #{opponent.name}!"
    opponent.health = opponent.health - 5
  end
end

# Drive code
overworld = World.new 'Overworld'
enderland = World.new 'Enderland'

skeleton =  ShootingType.new "Skeleton", 20, overworld
enderman = TeleportType.new "Enderman", 40, enderland

# puts 'Initial skeleton health: ' + skeleton.health.to_s
# puts 'Initial enderman health: ' + enderman.health.to_s

# skeleton.attack enderman
# skeleton.attack enderman
# skeleton.attack enderman
# skeleton.attack enderman

# puts 'New skeleton health ' + skeleton.health.to_s
# puts 'New enderman health ' + enderman.health.to_s

skeleton.save