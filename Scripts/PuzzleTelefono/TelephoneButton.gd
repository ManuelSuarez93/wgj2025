extends Button

class_name  TelephoneButton

@export var telephoneSound : Array[AudioStream]

signal telephoneButtonPressed(number : String)

func _ready():
	button_down.connect(buttonPress)

func buttonPress():
	telephoneButtonPressed.emit(text)
	GameManager.UI.playSound(telephoneSound[RandomNumberGenerator.new().randi_range(0,telephoneSound.size()-1)])
	
	
