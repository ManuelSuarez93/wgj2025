extends Control

class_name PlayerUI

@export_group("Cursors")
@export var Opened_Hand : Control
@export var Closed_Hand : Control 
@export_group("Game menus") 
@export var Pause_Menu : MenuPause 
@export var Game_Over_Menu : GameOverMenu
@export var Hangman_Menu : HangmanMenu
@export var Telephnone_Menu : PhoneMenu
@export var Picture_Menu : PictureMenu
@export_group("Audio")
@export var uiAudioEffects : AudioStreamPlayer
@export var BlackoutImage : ColorRect

@onready var Menus = {
 	UIMenu.MenuType.Phone: Telephnone_Menu, 
 	UIMenu.MenuType.Photo: Picture_Menu, 
 	UIMenu.MenuType.Hangman: Hangman_Menu
	}
 
var collider : Triggerable  
var currentMenu : UIMenu.MenuType   
var is_interacting : bool = false

func _ready():  
	currentMenu = UIMenu.MenuType.None
	GameManager.Player.interacted.connect(interact)   
	captureMouse()

func _input(event):
	if event.is_action_pressed("ui_cancel"): 
		setPauseMenu()
		captureMouse() 

func captureMouse():
	if (!GameManager.LevelStarted):   
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif (GameManager.LevelOver):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else: 
		if(GameManager.GamePaused): 
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else: 
			if(currentMenu != UIMenu.MenuType.None):  
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			else:  
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func interact(): 
	is_interacting = true
	Closed_Hand.visible = true
	Opened_Hand.visible = false
	await get_tree().create_timer(0.3).timeout
	is_interacting = false

func onDetectedObject(collider):  
	if is_interacting == false:
		Closed_Hand.visible = false
		Opened_Hand.visible = true

func onNonDetectingObject(): 
	Closed_Hand.visible = false
	Opened_Hand.visible = false

func setMenuVisible(menuToOpen : UIMenu.MenuType, isVisible : bool, enableMovement : bool): 
	GameManager.Player.enableMovement = enableMovement
	if(menuToOpen != UIMenu.MenuType.None):
		Menus[menuToOpen].visible = isVisible
		if(isVisible) : currentMenu = menuToOpen
		else: currentMenu = UIMenu.MenuType.None
	else:
		for menu in Menus:
			menu.visible = false
		currentMenu = UIMenu.MenuType.None
		
	captureMouse()

func setPauseMenu():
	Pause_Menu.visible = !Pause_Menu.visible
	GameManager.pauseGame(Pause_Menu.visible)

func setGameOver(): 
	Game_Over_Menu.visible = true
	GameManager.LevelOver = true

func playSound(sound : AudioStream):
	uiAudioEffects.stop()
	uiAudioEffects.stream = sound
	uiAudioEffects.play()
