extends UIMenu

class_name PhoneMenu

@export var Solution : String

@export var Numpad : Control
@export_group("NumberDisplay")
@export var NumberText : Label
@export var NumberLimit : int

@export_group("Audio")
@export var callCorrectAudio : AudioStream
@export var callIncorrectAudio : AudioStream

@export_group("Buttons")
@export var callButton : Button

var numbers : String

signal onCallCorrect(enable : bool)

func _ready():
	quitButton.pressed.connect(closeMenu)
	callButton.pressed.connect(doCall)

	for button in Numpad.get_children():
		if button is TelephoneButton: 
			button.telephoneButtonPressed.connect(onTelephoneButtonPressed)

func onTelephoneButtonPressed(number : String): 
	if(numbers.length() <= NumberLimit):
		numbers += number
		NumberText.text = numbers

func doCall(): 
	checkIfNumberCorrect() 
	NumberText.text = ""
	numbers = ""
	
func checkIfNumberCorrect():
	if(numbers == Solution):
		onCallCorrect.emit(false)
		GameManager.UI.playSound(callCorrectAudio)
	else: 
		GameManager.UI.playSound(callIncorrectAudio)

func closeMenu(): 
	GameManager.UI.setMenuVisible(UIMenu.MenuType.Phone, false, true)
