extends Node3D

var player : Player:
	get:
		if player == null: 
			player = get_tree().get_first_node_in_group("Player")
		return player
		
var enviroment : WorldEnvironment:
	get:
		if enviroment == null: 
			enviroment = get_tree().get_first_node_in_group("Enviroment")
		return enviroment
