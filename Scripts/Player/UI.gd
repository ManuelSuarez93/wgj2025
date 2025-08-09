extends Control

class_name PlayerUI

@export var ManoAbierta : Control
@export var ManoCerrada : Control 
@export var MenuHangman : Control

var collider : Triggerable 
var isOnMenu : bool

func _ready():
	isOnMenu = false
	# Capturar y ocultar el mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	captureMouse(event)

func captureMouse(event):
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
			GameManager.player.setEnableMovement(false)
		else:
			MenuHangman.visible = false 
			GameManager.player.setEnableMovement(true)
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func interact():
	pass

func onDetectedObject(collider):  
	ManoCerrada.visible = true
	ManoAbierta.visible = false
	
func onNonDetectingObject(): 
	ManoCerrada.visible = false
	ManoAbierta.visible = false
	
func SetMenuHangmanVisible():  
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GameManager.player.setEnableMovement(false)
	isOnMenu = !MenuHangman.visible 
	MenuHangman.visible = !MenuHangman.visible
