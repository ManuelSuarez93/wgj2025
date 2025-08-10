extends Control

@export var game_over_audio : AudioStreamPlayer
@export_category("Audio")
@export var audioCorrect : AudioStream
@export var audioIncorrect : AudioStream

var letters : Array[HangmanLetter]

signal solutionFound
 
func _ready() -> void:
	
	for letter in get_tree().get_nodes_in_group("HangmanLetter"):
		if letter is HangmanLetter:
			letters.append(letter)
			letter.onLetterPressed.connect(onLetterSubmitted) 

func onLetterSubmitted(letter: HangmanLetter):
	var audioPlayer = GameManager.player.AudioPlayer
	
	audioPlayer.stop()
	if(letter.isCorrectLetter()):
		audioPlayer.stream = audioCorrect
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
		GameManager.player.UI.SetMenuVisible(PlayerUI.Menu.GameOver, true, false)
		game_over_audio.play()
		get_tree().paused = true
		
