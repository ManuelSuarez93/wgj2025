extends Button

class_name  TelephoneButton

signal telephoneButtonPressed(number : String)
func _ready():
	button_down.connect(buttonPress)

func buttonPress():
	telephoneButtonPressed.emit(text)
	
	
