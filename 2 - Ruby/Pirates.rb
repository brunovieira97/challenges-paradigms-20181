# Pirates of the Caribbean - Naval Battle
# 0 = agua / 1 = nos / 2 = inimigo normal / 3 = fantasma / 4 = ja atirou

require 'matrix'

class Mapa
  attr_accessor :matriz
  attr_reader :matriz
  attr_writer :matriz

  PECAS = [{ "size": 2, "key": 1}, { "size": 2, "key": 2}, { "size": 2, "key": 2}, { "size": 3, "key": 3}]

  def initialize
    @matriz = Array.new(8) { Array.new(3, 0) } 

    insereNavios()
  end
  
  def obtemCoordenada
    coord = {}
    coord['x'] = rand(7)
    coord['y'] = rand(2)
    
    coord
  end
  
  def atira(x, y)
    if (x > 7 or y > 2 or x < 0 or y < 0)
      puts "Posicao invalida"
    elsif (matriz[x][y] == 1)
      puts "Voce esta aqui!"
    elsif (matriz[x][y] == 2 or matriz[x][y] == 3)
      puts "Acertou o inimigo"
      self.matriz[x][y] = 4
    else
      puts "Tiro na agua"
    end
  end
  
  def ganhou
    countNormal = 0
    countFantasma = 0
    for y in 0..2
      for x in 0..7
        if (self.matriz[x][y] == 2)
          countNormal = countNormal + 1
        elsif (self.matriz[x][y] == 3)
          countFantasma = countFantasma + 1
        end
      end
    end
    if (countFantasma == 0)
      puts "Ganhou"
    elsif (countNormal == 0)
      puts "Ganhou"
    end
  end
  
  def verificaCoordenada(coord, size, direcao)
    x = coord['x']
    y = coord['y']

    while size > 0
      p "x: " + x.to_s
      p "y: " + y.to_s
      p self.matriz
      if x < self.matriz.length and y < self.matriz[0].length and self.matriz[x][y] == 0
        size = size -1
        if direcao == 1
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
  
  def insereNavios()

    for navio in PECAS
      posicao = obtemCoordenada()
      direcao = rand(0..1)
      
      while !verificaCoordenada(posicao, navio[:size], direcao)
        direcao = rand(0..1)
        posicao = obtemCoordenada()
      end
      
      size = navio[:size]
      while size > 0
        self.matriz[posicao['x']][posicao['y']] = navio[:key]

        if direcao == 1
          posicao['x'] = posicao['x'] + 1
        else
          posicao['y'] = posicao['y'] + 1
        end
        
        size -= 1
      end
    end
  end
  
  def print
    for y in 0..2
      output = ""
      for x in 0..7
        output = output + "\t" + matriz[x][y].to_s
      end
      puts output
    end
  end
end

mapa = Mapa.new()

mapa.print()
