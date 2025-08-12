extends LineEdit

class_name HangmanLetter

@export var index : int
@export var correctLetter : String

signal onLetterPressed(letter: HangmanLetter)

func _ready():
	text_submitted.connect(onTextChanged)
	
func onTextChanged(newText : String):
	text = text.to_upper()
	if(!isCorrectLetter()):
		text = ""
	onLetterPressed.emit(self)
		
func isCorrectLetter() -> bool:
	return text.to_upper() == correctLetter
