extends Control

@export var solution : String
@export var letters : Array[LineEdit]

func _ready() -> void:
	for letter in letters:
		if letter is HangmanLetter:
			letter.textChanged.connect(isCorrectLetter)
	
func isCorrectLetter(letter : String, letterIndex : int):
	if(letter[0] == solution[letterIndex]): 
		pass
	else:
		pass
	
	
