extends Node3D

class_name CinematicsManager

@export_group("Escenas")
@export_subgroup("Comienzo")
@export var Timer_Comienzo_Escena : Timer
@export var Luz_Comienzo : Light3D 
@export var Audio_Luz : AudioStream
@export var Audio_Respiracion : AudioStream
@export var Audio_Luz_Player : AudioStreamPlayer3D

@export_subgroup("Llamada telefonica")
@export var Timer_Comienza_Llamada : Timer
@export var Timer_Termina_Llamada : Timer
@export var AudioTelefono : AudioStreamPlayer

@export_subgroup("Final")
@export var Timer_Termina_Ahorcado : Timer
@export var Timer_Grito : Timer 
@export var Audio_Esposas : AudioStreamPlayer
@export var Audio_Grito : AudioStreamPlayer
@export var Audio_GameOver : AudioStreamPlayer


@export_group("Dialogo")
@export var Dialogue_player : AudioStreamPlayer
@export_group("Musica")
@export var Musica : AudioStreamPlayer

@export_group("Areas")
@export var Calendario: PuzzleArea
@export var Fotos: PuzzleArea
@export var Ahorcado: PuzzleArea

var Dialogo1 : AudioStream = preload("res://Assets/Sounds/Dialogue/audio 1.wav")
var Dialogo2 : AudioStream = preload("res://Assets/Sounds/Dialogue/audio 2.wav")
var Dialogo3 : AudioStream = preload("res://Assets/Sounds/Dialogue/audio 3.wav")
var LetMeExplain : AudioStream = preload("res://Assets/Sounds/Dialogue/letMeExplain.wav")
var Grito : AudioStream = preload("res://Assets/Sounds/foleys/sonidos del personaje/Grito/gritoFinal.wav")
var Esposas : AudioStream = preload("res://Assets/Sounds/foleys/sonido esposas.wav")
var GameOver : AudioStream = preload("res://Assets/Sounds/game over.wav")

var MainMenu : PackedScene = preload("res://Scenes/main_menu.tscn")
var PlayScene : PackedScene = preload("res://Scenes/PlayScene.tscn")
var Creditos : PackedScene = preload("res://Scenes/end_credits.tscn")
func _ready(): 
	GameManager.LevelOver = false
	GameManager.LevelStarted = false
	#Seteo de comienzo
	GameManager.UI.Telephnone_Menu.onCallCorrect.connect(onTelephonePuzzleFinished)
	Timer_Comienzo_Escena.timeout.connect(onTimerFirstSceneFinished)
	GameManager.Cinematics.playDialogue(GameManager.Cinematics.Dialogo1)
	#Seteo llamada
	
	Timer_Comienza_Llamada.timeout.connect(func():
		GameManager.Player.isInCinematic = true
		AudioTelefono.stream = LetMeExplain
		AudioTelefono.play())
	Timer_Termina_Llamada.timeout.connect(func(): 
		GameManager.Player.isInCinematic = false
		GameManager.UI.Telephnone_Menu.closeMenu()
		playDialogue(Dialogo2)
		Calendario.Door.open())
	
	#Seteo foto
	Fotos.puzzleFinished.connect(func():
		GameManager.Player.isInCinematic = true
		GameManager.UI.Picture_Menu.PlayAnimation(func(): 
			GameManager.Player.isInCinematic = false
			playDialogue(GameManager.Cinematics.Dialogo3)
			Fotos.Door.open()
			)
		)

	#Seteo ahorcado
	Ahorcado.puzzleFinished.connect(func():
		Dialogue_player.stop()
		Audio_Esposas.play()
		GameManager.Player.isInCinematic = true
		Timer_Termina_Ahorcado.start()
		)
		
	Timer_Termina_Ahorcado.timeout.connect(func(): 
		Audio_GameOver.play()
		Audio_Grito.play()
		Timer_Grito.start()
		GameManager.UI.setGameOver())
	
	Timer_Grito.timeout.connect(func(): get_tree().change_scene_to_packed(Creditos))
	
func onTimerFirstSceneFinished():
	Luz_Comienzo.visible = true
	Audio_Luz_Player.stream = Audio_Luz
	Audio_Luz_Player.play()
	GameManager.Player.playEffectSounds(Audio_Respiracion)
	GameManager.LevelStarted = true
	GameManager.Player.enableMovement = true
	GameManager.UI.BlackoutImage.visible = false

func onTelephonePuzzleFinished(enable : bool):
	Timer_Comienza_Llamada.start()
	Timer_Termina_Llamada.start()
	Musica.play()
	

func playDialogue(sound : AudioStream):
	Dialogue_player.stop()
	Dialogue_player.stream = sound
	Dialogue_player.play()
