=begin
  Map identifiers
  0 - Water
  1 - Our ship
  2 - EIC enemy ship
  3 - Flying Dutch
  4 - Hit 
  5 - Shoot at water
=end

require 'matrix'

class SeaMap
  attr_accessor :matrix
  attr_reader :matrix
  attr_writer :matrix

  PIECES = [{ "size": 2, "key": 1}, { "size": 2, "key": 2}, { "size": 2, "key": 2}, { "size": 3, "key": 3}]

  def initialize
    @matrix = Array.new(8) { Array.new(3, 0) } 
    insertShips()
  end

  def getCoordinates
    coord = {}
    coord['x'] = rand(7)
    coord['y'] = rand(2)
    coord
  end
  
  def shoot(x, y)
    if (x > 8 or y > 3 or x <= 0 or y <= 0)
      puts "Posicão inválida!"
    elsif (matrix[x-1][y-1] == 1)
      puts "Voce está aqui."
    elsif (matrix[x-1][y-1] == 2 or matrix[x-1][y-1] == 3)
      puts "Acertou o inimigo!"
      self.matrix[x-1][y-1] = 4
    else
      puts "Tiro na água!"
      self.matrix[x-1][y-1] = 5
    end
  end
  
  def won
    blackPearl = 0
    ghost = 0
    for y in 0..2
      for x in 0..7
        if (self.matrix[x][y] == 2)
          blackPearl += 1
        elsif (self.matrix[x][y] == 3)
          ghost += 1
        end
      end
    end
    if (blackPearl == 0 or ghost == 0)
      return true
    end

    return false
  end
  
  def verifyCoordinates(coord, size, direction)
    x = coord['x']
    y = coord['y']

    while size > 0
      if x < self.matrix.length and y < self.matrix[0].length and self.matrix[x][y] == 0
        size = size -1
        if direction == 1
          x = x + 1
        else
          y = y + 1
        end
      else
        return false
      end
    end
    
    return true
  end
  
  def insertShips()
    for ship in PIECES
      position = getCoordinates()
      direction = rand(0..1)
      
      while !verifyCoordinates(position, ship[:size], direction)
        direction = rand(0..1)
        position = getCoordinates()
      end
      
      size = ship[:size]
      while size > 0
        self.matrix[position['x']][position['y']] = ship[:key]

        if direction == 1
          position['x'] = position['x'] + 1
        else
          position['y'] = position['y'] + 1
        end
        
        size -= 1
      end
    end
  end
  
  def print
    for y in 0..2
      output = ""
      for x in 0..7
        output = output + "\t" + matrix[x][y].to_s
      end
      puts output
    end
  end

   def showToPlayer
    for y in 0..2
      output = ""
      for x in 0..7
        if matrix[x][y] == 1 or matrix[x][y] == 4 or matrix[x][y] == 5
          output = output + "\t" + matrix[x][y].to_s
        else
          output = output + "\t" + '0'
        end
      end
      puts output 
    end
  end
end

map = SeaMap.new()
kraquen = rand(7..24)

puts "O jogo pirata vai começar!"
map.showToPlayer
#map.print()

won = false
count = 0

while (won == false and count < kraquen) do
  puts "Informe a coluna (eixo X) na qual você deseja atirar:"
  x = gets.chomp.to_i
  puts "Informe a linha (eixo Y) na qual você deseja atirar:"
  y = gets.chomp.to_i

  map.shoot(x, y);
  map.showToPlayer()
  #map.print()

  if (map.won())
    won = true
  end

  count += 1
end

if (won == true)
  puts "Você é um baita pirata! Ganhou sapequinha!"
elsif
  puts "No céu tem pão? E morreu!"
end
