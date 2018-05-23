=begin
  Map identifiers
  0 - Water
  1 - Our ship
  2 - EITC enemy ship
  3 - Flying Dutch
  4 - Hit 
  5 - Shot on water
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
    if !isValidCoordinate(x, y)
      puts "Posicão inválida!"
    else
      coordinateValue = matrix[x-1][y-1]
      newValue = 0

      if (coordinateValue == 1)
        puts "Voce está aqui."
      elsif (coordinateValue.between?(2, 3))
        puts "Acertou o inimigo!"
        newValue = 4
      elsif (coordinateValue.between?(4, 5))
        puts "Posição já acertada!"
      else
        puts "Tiro na água!"
        newValue = 5
      end

      if newValue > 0
        changeCoordinateValue(x, y, newValue)
      end
    end
  end
  
  def won
    enemyCount = 0
    for y in 0..2
      for x in 0..7
        if (self.matrix[x][y].between?(2, 3))
          enemyCount += 1
        end
      end
    end
    if (enemyCount != 0)
      return false
    end
    return true
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

  def isValidCoordinate(x, y)
    if (x > 8 or y > 3 or x <= 0 or y <= 0)
      return false
    end
    return true
  end

  def changeCoordinateValue(x, y, newValue)
    self.matrix[x-1][y-1] = newValue
  end
end

map = SeaMap.new()
krakenRound = rand(7..24)

puts "O jogo pirata vai começar!"
map.showToPlayer

hasWon = false
roundCount = 0

while (hasWon == false and roundCount <= krakenRound) do
  puts "Informe a coluna (eixo X) na qual você deseja atirar:"
  x = gets.chomp.to_i
  puts "Informe a linha (eixo Y) na qual você deseja atirar:"
  y = gets.chomp.to_i

  map.shoot(x, y);
  map.showToPlayer()

  if (map.won())
    hasWon = true
  elsif (roundCount == krakenRound)
    puts "O Kraken foi solto!"
  end
  roundCount += 1
end

if hasWon
  puts "Você é um baita pirata! Ganhou sapequinha!"
else
  puts "No céu tem pão? E morreu!"
end