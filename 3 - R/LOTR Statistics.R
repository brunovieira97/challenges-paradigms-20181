mordor_types <- c("Orcs", "Oliphaunts", "Easterlings", "Weapons")
mordor_numbers <- c(200000, 1500, 18000, 218500)
names(mordor_numbers) <- mordor_types

# Note: Oathbreakers don't die
gondor_types <- c("Humans", "Horses", "Oathbreakers", "Weapons")
gondor_numbers <- c(19000, 6000, 50000, 75000)
names(gondor_numbers) <- gondor_types
starting_gondor_numbers <- gondor_numbers

battle_names <- c("Osgiliath 1", "Osgiliath 2", "Pelennor Fields", "Helm's Deep", "Blackgate")

mordor_battle_deaths <- c(0, 0, 0, 0, 0)
names(mordor_battle_deaths) <- battle_names

gondor_battle_deaths <- c(0, 0, 0, 0, 0)
names(gondor_battle_deaths) <- battle_names

battle_count <- 1
type_count <- 1

mordor_wins <- 0
gondor_wins <- 0

print("===================BATTLES===================")
for (battle_count in 1:5) {
	print(battle_names[battle_count])
	
	print("")
	print("Mordor:")
	print(mordor_numbers)
	print("")
	print("Gondor:")
	print(gondor_numbers)
	
	# Mordor deaths
	print("")
	for (type_count in 1:4) {
		deaths <- sample(10:300, 1)
    	mordor_numbers[type_count] <- mordor_numbers[type_count] - deaths
		print(paste("Mordor: Lost", deaths, mordor_types[type_count], sep=" "))
		mordor_battle_deaths[battle_count] <- mordor_battle_deaths[battle_count] + deaths
		type_count <- type_count + 1
	}
	
	type_count <- 0
	
	print("")
	
	# Gondor deaths
	for (type_count in 1:4) {
		deaths <- sample(10:300, 1)
		if (type_count != 3) {
    		gondor_numbers[type_count] <- gondor_numbers[type_count] - deaths
    		print(paste("Gondor: Lost", deaths, gondor_types[type_count], sep=" "))
    		gondor_battle_deaths[battle_count] <- gondor_battle_deaths[battle_count] + deaths
    	}
		type_count <- type_count + 1
	}
	
	print("")
	if (mordor_battle_deaths[battle_count] < gondor_battle_deaths[battle_count]) {
	    mordor_wins <- mordor_wins + 1
	    print("Mordor wins!")
	} else if (mordor_battle_deaths[battle_count] > gondor_battle_deaths[battle_count]) {
	    gondor_wins <- gondor_wins + 1
	    print("Gondor wins!")
	}
	
	battle_count <- battle_count + 1
	print("=============================================")
}

print("==================STATISTICS=================")
print(paste("You won", gondor_wins, "battles"))
print("")
print(paste("You lost", mordor_wins, "battles"))
print("")

print(paste("The battle in which you lost the most amount of soldiers was", battle_names[which.max(gondor_battle_deaths)]))
print("")
print(paste("The battle in which you lost the least amount of soldiers was", battle_names[which.min(gondor_battle_deaths)]))
print("")

print("===================INSIGHTS==================")
print(paste("You lost", starting_gondor_numbers[4] - gondor_numbers[4], "weapons. Train your soldiers' grip of weapons!"))
print("")
print(paste("The unit with the most amount of deaths was", gondor_types[which.max(starting_gondor_numbers[1:3] - gondor_numbers[1:3])]))

print("====================GRAPHS===================")
plot(gondor_battle_deaths, type="h", col="darkgreen")
title(main = "Deaths per battle", font.main=2)