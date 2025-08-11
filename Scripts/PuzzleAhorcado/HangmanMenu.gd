extends UIMenu

class_name HangmanMenu

@export_category("Audio")
@export var audioCorrect : AudioStream
@export var audioIncorrect : AudioStream
@export var ahorcadoImages : Array[Control]

var letters : Array[HangmanLetter]

func _ready() -> void:
	
	for letter in get_tree().get_nodes_in_group("HangmanLetter"):
		if letter is HangmanLetter:
			letters.append(letter)
			letter.onLetterPressed.connect(onLetterSubmitted) 

func onLetterSubmitted(letter: HangmanLetter):
	var audioPlayer = GameManager.Player.AudioPlayer
	
	audioPlayer.stop()
	if(letter.isCorrectLetter()):
		audioPlayer.stream = audioCorrect
		for image in ahorcadoImages:
			if !image.visible:
				image.visible = true
				break
	else:
		audioPlayer.stream = audioIncorrect
	audioPlayer.play() 
	checkAllCorrectLetters()

func checkAllCorrectLetters():
	var correctLetters = 0
	for letter in letters:
			if letter.isCorrectLetter():
				letter.editable = false;
				correctLetters += 1
	
	if(correctLetters == letters.size()):
		GameManager.UI.setMenuVisible(UIMenu.MenuType.GameOver, true, false)
		
