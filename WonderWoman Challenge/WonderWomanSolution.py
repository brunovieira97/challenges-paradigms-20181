import string
from random import random, randint, shuffle

def selectWord():
  words = ['GUERRA', 'ALEMANHA', 'GÁS', 'MORTAL', 'ARMAS', 'INIMIGO', 'GANHAR', 'PERDER', 'BATALHA', 'EXERCITO', 'SOLDADO']
  return words[randint(0, len(words)-1)]

def shuffleWord(selectedWord):
  chars = list(selectedWord)
  shuffle(chars)
  return ''.join(chars)

def letterChanges(shuffledWord):
  index = 0
  newWord = ""
  alphapet = "ABCDEFGHIJKLMNOPQRSTUVWXYZA"

  for i in shuffledWord.upper():
      if i.isupper():
          index = alphapet.index(i) + 1
          newWord += alphapet[index]    
      else: 
          newWord += i    
  return newWord

def main():
  print("Olá princesa Diana!\nVocê consegue desvendar a mensagem de Dr. Maru?")

  selectedWord = selectWord()
  mensage = letterChanges(shuffleWord(selectedWord))
  print(mensage[0:4])
  
  for i in range(1, 6):
    answer = input('Mensagem:')  
    if (answer != selectedWord):
      if (i == 5):
        print("Os alemães liberarão o gás mortal na Frente Ocidental da Bélgica!!!\nTodos morreram, inclusive você!")
      else:
        print("Você ainda tem " + str(5-i) + " tentativas!")
    
    else: 
      print("Ufa.... essa foi por pouco!\nAgora você já sabe os planos do exército alemão! Parabéns!")
      break

main()