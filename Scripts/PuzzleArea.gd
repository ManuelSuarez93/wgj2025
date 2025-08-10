extends Node3D

class_name PuzzleArea

@export var Door : Door 

var puzzles : Array[Triggerable]
var finishedPuzzles: Array[Triggerable]

func checkForPuzzles():
	for children in self.get_children():
		if children is Triggerable:
			puzzles.append(children)
			children.onTrigger.connect(puzzleSolved)

func puzzleSolved(puzzle : Triggerable):
	finishedPuzzles.append(puzzle)
	checkForFinishPuzzles()
	
func checkForFinishPuzzles():
	if(finishedPuzzles.size() == puzzles.size()):
		finishPuzzle()
		
func finishPuzzle():
	Door.open()
