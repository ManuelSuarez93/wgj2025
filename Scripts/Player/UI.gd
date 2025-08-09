extends Control

class_name PlayerUI

@export var ManoAbierta : Control
@export var ManoCerrada : Control
@export var Pointer : ColorRect 

var Collider : Triggerable 

func _ready():
	# Capturar y ocultar el mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	captureMouse(event)

func captureMouse(event):
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
func interact():
	pass

func onDetectedObject(collider):  
	ManoCerrada.Visible = true
	ManoAbierta.Visible = false
	
func onNonDetectingObject(): 
	ManoCerrada.Visible = false
	ManoAbierta.Visible = false
	
