extends Node

var Player : PlayerChar:
	get:
		if Player == null: 
			Player = get_tree().get_first_node_in_group("Player")
		return Player
		
var Enviroment : WorldEnvironment:
	get:
		if Enviroment == null: 
			Enviroment = get_tree().get_first_node_in_group("Enviroment")
		return Enviroment

var Cinematics : CinematicsManager:	
	get:
		if Cinematics == null: 
			Cinematics = get_tree().get_first_node_in_group("Cinematics")
		return Cinematics

var UI : PlayerUI:
	get:
		if UI == null: 
			UI = get_tree().get_first_node_in_group("UI")
		return UI

var LevelStarted : bool
var LevelOver : bool
var GamePaused : bool

func pauseGame(pause : bool):
	Player.setEnableMovement(!pause)
	GamePaused = pause
	get_tree().paused = pause
