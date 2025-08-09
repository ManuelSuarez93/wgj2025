extends LineEdit

class_name HangmanLetter

@export var index : int
@export var correctLetter : String

signal onLetterPressed(letter: HangmanLetter)

func _ready():
	text_submitted.connect(onTextChanged)
	
func onTextChanged(newText : String):
	if(text == ""):
		text = "_"
	else:
		onLetterPressed.emit(self)
		
func isCorrectLetter() -> bool:
	return text == correctLetter
