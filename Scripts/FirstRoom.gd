extends Node3D

@export var timerLuzComienzo : Timer
@export var luzComienzo : Light3D

func _ready():
	timerLuzComienzo.timeout.connect(func(): luzComienzo.visible = true)
