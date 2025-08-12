extends UIMenu

class_name HangmanMenu

@export_category("Audio")
@export var audioCorrect : AudioStream
@export var audioIncorrect : AudioStream
@export var ahorcadoImages : Array[Control]

var letters : Array[HangmanLetter]
signal allLettersCorrect

func _ready() -> void:
	allLettersCorrect.connect(GameManager.Cinematics.Ahorcado.puzzleFinished.emit)
	quitButton.pressed.connect(func(): GameManager.UI.setMenuVisible(UIMenu.MenuType.Hangman,false,true))
	for letter in get_tree().get_nodes_in_group("HangmanLetter"):
		if letter is HangmanLetter:
			letters.append(letter)
			letter.onLetterPressed.connect(onLetterSubmitted) 

func onLetterSubmitted(letter: HangmanLetter):
	if(letter.isCorrectLetter()): 
		GameManager.UI.playSound(audioCorrect) 
		for image in ahorcadoImages:
			if !image.visible:
				image.visible = true
				break
	else:
		GameManager.UI.playSound(audioIncorrect) 
	checkAllCorrectLetters()

func checkAllCorrectLetters():
	var correctLetters = 0
	for letter in letters:
			if letter.isCorrectLetter():
				letter.editable = false;
				correctLetters += 1
	
	if correctLetters == letters.size():
		allLettersCorrect.emit()
	
