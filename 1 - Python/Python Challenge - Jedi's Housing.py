# This Python file uses the following encoding: windows-1252
import random

coordinates = {
	'N': [ 0, -1],
	'S': [ 0,  1],
	'E': [ 1,  0],
	'W': [-1,  0] 
}

jedi = {'gotLightsaber': False, 'x': 0, 'y': 1}

livingRoom =  {'name': "Living Room", 'hasLightsaber': False}
kitchen = {'name': "Kitchen", 'hasLightsaber': False}
entrance = {'name': "Entrance", 'hasLightsaber': False}
studyRoom = {'name': "Study Room", 'hasLightsaber': False}
boysDorm = {'name': "Boys' Dorm", 'hasLightsaber': False}
girlsDorm = {'name': "Girls' Dorm", 'hasLightsaber': False}

rooms = [livingRoom, kitchen, entrance, studyRoom, girlsDorm, girlsDorm]

jediHouse = [
	[0,			studyRoom, 		boysDorm],
	[entrance, 	livingRoom, 	girlsDorm],
	[0, 		kitchen, 		0]
]

def main():
	print("Welcome, Padawan! Can you find your lightsaber?")

	roomWithLightsaber = rooms[0] #random.choice(rooms)
	roomWithLightsaber['hasLightsaber'] = True

	while not jedi['gotLightsaber']:
		direction = input("Type the direction you want to go (N, S, E, W): " )

		newPosition = getNewPosition(direction, jedi)

		if not (newPosition[0] < 0 or newPosition[0] > 2) or (newPosition[1] < 0 or newPosition[1] > 2):
			currentRoom = jediHouse[newPosition[0]][newPosition[1]]
			
			if not currentRoom == 0:
				jedi['x'] = newPosition[0]
				jedi['y'] = newPosition[1]
				if currentRoom['hasLightsaber']:
					print(currentRoom['name'])
					break
			else:
				print("There's nothing there! Choose a valid direction.")
		else:
			currentRoom = jediHouse[1][0]


def getNewPosition(direction, jedi):
	coordX = jedi['x']
	coordY = jedi['y']

	newDirection = coordinates[direction]

	return [coordX + newDirection[0], coordY + newDirection[1]]


main()