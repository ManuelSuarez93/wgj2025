extends LineEdit

class_name HangmanLetter

@export var index : int

signal textChanged(letter: String, index : int)

func ready():
	text_submitted.connect(onTextChanged)
	
func onTextChanged(newText : String):
	if(text == ""):
		text = "_"
