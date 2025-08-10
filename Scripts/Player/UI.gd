extends Control

class_name PlayerUI

enum Menu {Phone, Photo, Hangman, None, Pause, GameOver}

@export var player : Player

@export var ManoAbierta : Control
@export var ManoCerrada : Control 
@export var MenuHangman : Control
@export var MenuTelefono : MenuPhone
@export var MenuPause : Control 
@export var MenuImages : MenuPicture
@export var MenuGameOver : Control

@export var play_button : TextureButton

@export var quit_button : TextureButton
@export var quitButtonPause : TextureButton

@onready var Menus := [MenuTelefono, MenuHangman, MenuPause, MenuImages, MenuGameOver]

var collider : Triggerable 
var isOnMenu : bool
var currentMenu : Menu

var is_interacting : bool = false

func _ready():
	isOnMenu = false
	player.interacted.connect(interact)
	
	quit_button.pressed.connect(func(): get_tree().quit())
	quitButtonPause.pressed.connect(func(): get_tree().quit())
	play_button.pressed.connect(func():
		isOnMenu = false
		SetMenuVisible(Menu.None, false, true) 
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED))
	# Capturar y ocultar el mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	captureMouse(event)

func captureMouse(event):
	if event.is_action_pressed("ui_cancel"):
		if !isOnMenu:
			isOnMenu = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			SetMenuVisible(Menu.Pause, true, false)
		else:
			isOnMenu = false
			SetMenuVisible(Menu.None, false, true) 
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func interact(): 
	is_interacting = true
	ManoCerrada.visible = true
	ManoAbierta.visible = false
	await get_tree().create_timer(0.3).timeout
	is_interacting = false

func onDetectedObject(collider):  
	if is_interacting == false:
		ManoCerrada.visible = false
		ManoAbierta.visible = true

func onNonDetectingObject(): 
	ManoCerrada.visible = false
	ManoAbierta.visible = false

func SetMenuVisible(menuToOpen : Menu, isVisible : bool, enableMovement : bool):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	GameManager.player.setEnableMovement(enableMovement)
	isOnMenu = isVisible
	if isOnMenu:
		currentMenu = menuToOpen
	match menuToOpen:
		Menu.Phone:
			MenuTelefono.visible = isVisible
			MenuHangman.visible = !isVisible
			MenuPause.visible = !isVisible
			MenuGameOver.visible = !isVisible
			
		Menu.Hangman:
			MenuHangman.visible = isVisible
			MenuTelefono.visible = !isVisible
			MenuPause.visible = !isVisible
			MenuGameOver.visible = !isVisible
		Menu.Pause:
			MenuHangman.visible = !isVisible
			MenuTelefono.visible = !isVisible
			MenuPause.visible = isVisible
			MenuGameOver.visible = !isVisible
		Menu.GameOver:
			MenuHangman.visible = !isVisible
			MenuTelefono.visible = !isVisible
			MenuPause.visible = !isVisible
			MenuGameOver.visible = isVisible
		Menu.None: 
			MenuHangman.visible = isVisible
			MenuTelefono.visible = isVisible
			MenuPause.visible = isVisible
			MenuGameOver.visible = isVisible
			currentMenu = Menu.None
