extends Control

class_name MenuPhone

@export var Solution : String
@export var NumberText : Label
@export var NumberLimit : int

@export var callCorrectAudio : AudioStream
@export var callIncorrectAudio : AudioStream
@export var callSoundPlayer : AudioStreamPlayer3D
@export var timerSoundPlayer : Timer

var numbers : String

signal onCallCorrect(enable : bool)
signal onCallWrong()

func _ready():
	timerSoundPlayer.timeout.connect(callSoundPlayer.stop)
	for button in self.get_children():
		if button is TelephoneButton: 
			button.telephoneButtonPressed.connect(onTelephoneButtonPressed)

func onTelephoneButtonPressed(number : String):
	numbers += number
	print(numbers.length())
	if(numbers.length() <= NumberLimit):
		NumberText.text = numbers 
		if numbers.length() == NumberLimit:
			checkForCall()
	
func checkForCall():
	if(numbers == Solution):
		onCallCorrect.emit(false)
		callSoundPlayer.stream = callCorrectAudio
		callSoundPlayer.play()
		timerSoundPlayer.start()
	else:
		NumberText.text = ""
		numbers = ""
		onCallWrong.emit() 		
		callSoundPlayer.stream = callIncorrectAudio
		callSoundPlayer.play()
