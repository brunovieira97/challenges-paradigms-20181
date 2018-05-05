# Pirates of the Caribbean - Naval Battle
# 0 = agua / 1 = nos / 2 = inimigo normal / 3 = fantasma / 4 = ja atirou

require 'matrix'

class Mapa
  attr_accessor :matriz
  attr_reader :matriz
  attr_writer :matriz
  def initialize
    @matriz = Array.new(8) { Array.new(3, 0) }
    # Nos
    @matriz[0][0] = 1
    @matriz[1][0] = 1
    
    # Inimigo normal 1
    @matriz[3][0] = 2
    @matriz[3][1] = 2
    
    # Inimigo normal 2
    @matriz[1][2] = 2
    @matriz[2][2] = 2
    
    # Fantasma
    @matriz[5][1] = 3
    @matriz[6][1] = 3
    @matriz[7][1] = 3
  end
  
  def insere(tipo)
    x = rand(0...7)
    y = rand(0...2)
    
    case tipo
    when 1..2 
      #if(@matriz[x][y] == 0)
    end
  end
  
  def atira(x, y)
    if (x > 7 or y > 2 or x < 0 or y < 0)
      puts "Posicao invalida"
    elsif (matriz[x][y] == 1)
      puts "Voce esta aqui!"
    elsif (matriz[x][y] == 2 or matriz[x][y] == 3)
      puts "Acertou o inimigo"
      matriz[x][y] = 4
    else
      puts "Tiro na agua"
    end
  end
  
  def ganhou
    countNormal = 0
    countFantasma = 0
    for y in 0..2
      for x in 0..7
        if (matriz[x][y] == 2)
          countNormal = countNormal + 1
        elsif (matriz[x][y] == 3)
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
mapa.atira(1,1)

mapa.print()