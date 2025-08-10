extends Node3D

@export_category("Luz")
@export var timerLuzComienzo : Timer
@export var luzComienzo : Light3D 
@export var audioLuz : AudioStream
@export var audioLuzPlayer : AudioStreamPlayer3D
@export_category("Musica")
@export var musica : AudioStreamPlayer3D

func _ready(): 
	GameManager.player.UI.MenuTelefono.onCallCorrect.connect(onPuzzleFinished)
	timerLuzComienzo.timeout.connect(onTimerLightFinished)
	
func onTimerLightFinished():
	luzComienzo.visible = true
	audioLuzPlayer.stream = audioLuz
	audioLuzPlayer.play()
	GameManager.player.levelStarted = true
	GameManager.player.enableMovement = true
	GameManager.player.UI.BlackoutImage.visible = false

func onPuzzleFinished(enable : bool):
	musica.play()
