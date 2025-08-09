extends Node3D

class_name PuzzleArea

@export var Door : Door 

var puzzles : Array[Triggerable]
var finishedPuzzles: Array[Triggerable]

func _ready():
	for children in self.get_children():
		if children is Triggerable:
			puzzles.append(children)
			children.onTrigger.connect(puzzleSolved)
			print("Added children!")

func puzzleSolved(puzzle : Triggerable):
	finishedPuzzles.append(puzzle)
	checkDoorOpen()
	
func checkDoorOpen():
	if(finishedPuzzles.size() == puzzles.size()):
		Door.open()
