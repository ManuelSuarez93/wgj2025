extends Control

class_name MenuPhone

@export var Solution : String
@export var NumberText : Label
@export var NumberLimit : int
var numbers : String

signal onCallCorrect()
signal onCallWrong()


func _ready():
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
		onCallCorrect.emit()
	else:
		NumberText.text = ""
		numbers = ""
		onCallWrong.emit()
