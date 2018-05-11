=begin
  Map identifiers
  0 - Water
  1 - Our ship
  2 - EIC enemy ship
  3 - Flying Dutch
  4 - Hit
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
    if (x > 7 or y > 2 or x < 0 or y < 0)
      puts "Posicao inválida!"
    elsif (matrix[x][y] == 1)
      puts "Voce está aqui."
    elsif (matrix[x][y] == 2 or matrix[x][y] == 3)
      puts "Acertou o inimigo!"
      self.matrix[x][y] = 4
    else
      puts "Tiro na água!"
    end
  end
  
  def won
    enemyCount = 0
    for y in 0..2
      for x in 0..7
        if (self.matrix[x][y] == 2 or self.matrix[x][y] == 3)
          enemyCount += 1
        end
      end
    end
    if enemyCount == 0
      puts "Ganhou!"
    end
  end
  
  def verifyCoordinates(coord, size, direction)
    x = coord['x']
    y = coord['y']

    while size > 0
      p "x: " + x.to_s
      p "y: " + y.to_s
      p self.matrix
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
end

map = SeaMap.new()

map.print()