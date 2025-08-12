extends Node2D

class_name EndCredits

@export var creditos : AnimatedSprite2D 
@export var quitButton : TextureButton

func _ready():
	quitButton.pressed.connect(get_tree().quit)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
