mordor_types <- c("Orcs", "Oliphaunts", "Easterlings", "Weapons")
mordor_numbers <- c(200000, 500, 18000, 218500)
names(mordor_numbers) <- mordor_types

# Note: Oathbreakers don't die
gondor_types <- c("Humans", "Horses", "Oathbreakers", "Weapons")
gondor_numbers <- c(19000, 6000, 50000, 75000)
names(gondor_numbers) <- gondor_types

battle_names <- c("Osgiliath 1", "Osgiliath 2", "Pelennor Fields", "Helm's Deep", "Blackgate")

mordor_battle_deaths <- c(0, 0, 0, 0, 0)
names(mordor_battle_deaths) <- battle_names

gondor_battle_deaths <- c(0, 0, 0, 0, 0)
names(gondor_battle_deaths) <- battle_names

battle_count <- 1
type_count <- 1

mordor_wins <- 0
gondor_wins <- 0

for (battle_count in 1:5) {
	print("")
	print("=============================================")
	print(paste("Battle:  ", battle_names[battle_count], ":", sep=""))
	
	print("Mordor:")
	print(gondor_numbers)
	
	print("Gondor:")
	print(mordor_numbers)
	
	# Mordor deaths
	for (type_count in 1:4) {
		deaths <- sample(10:200, 1)
    	mordor_numbers[type_count] <- mordor_numbers[type_count] - deaths
		print(paste("Mordor:", deaths, mordor_types[type_count], "died.", sep=" "))
		mordor_battle_deaths[battle_count] <- mordor_battle_deaths[battle_count] + deaths
		type_count <- type_count + 1
	}
	
	type_count <- 0
	
	print("")
	
	# Gondor deaths
	for (type_count in 1:3) {
		deaths <- sample(10:200, 1)
		if (type_count != 3) {
    		gondor_numbers[type_count] <- gondor_numbers[type_count] - deaths
    		print(paste("Gondor:", deaths, gondor_types[type_count], "died.", sep=" "))
    		gondor_battle_deaths[battle_count] <- gondor_battle_deaths[battle_count] + deaths
    	}
		type_count <- type_count + 1
	}
	
	battle_count <- battle_count + 1
}