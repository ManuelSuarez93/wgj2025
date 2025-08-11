extends Node3D

class_name CinematicsManager

@export_group("Primera escena")
@export var Timer_Comienzo_Escena : Timer
@export var Luz_Comienzo : Light3D 
@export var Audio_Luz : AudioStream
@export var Audio_Respiracion : AudioStream
@export var Audio_Luz_Player : AudioStreamPlayer3D

@export_group("Dialogo")
@export var Dialogue_player : AudioStreamPlayer
@export_group("Musica")
@export var Musica : AudioStreamPlayer

var Dialogo1 : AudioStream = preload("res://Assets/Sounds/Dialogue/audio 1.wav")
var Dialogo2 : AudioStream = preload("res://Assets/Sounds/Dialogue/audio 2.wav")
var Dialogo3 : AudioStream = preload("res://Assets/Sounds/Dialogue/audio 3.wav")

func _ready(): 
	GameManager.LevelOver = false
	GameManager.LevelStarted = false
	GameManager.UI.Telephnone_Menu.onCallCorrect.connect(onTelephonePuzzleFinished)
	Timer_Comienzo_Escena.timeout.connect(onTimerFirstSceneFinished)
	GameManager.Cinematics.playDialogue(GameManager.Cinematics.Dialogo1)
	
func onTimerFirstSceneFinished():
	Luz_Comienzo.visible = true
	Audio_Luz_Player.stream = Audio_Luz
	Audio_Luz_Player.play()
	GameManager.Player.playEffectSounds(Audio_Respiracion)
	GameManager.LevelStarted = true
	GameManager.Player.enableMovement = true
	GameManager.UI.BlackoutImage.visible = false

func onTelephonePuzzleFinished(enable : bool):
	Musica.play()

func playDialogue(sound : AudioStream):
	Dialogue_player.stop()
	Dialogue_player.stream = sound
	Dialogue_player.play()
