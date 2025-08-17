extends Node3D

class_name PuzzleArea

@export var Door : Door 
@export var PuzzleType : String

var puzzles : Array[Triggerable]
var finishedPuzzles: Array[Triggerable]

signal puzzleFinished

func checkForPuzzles():
	for children in get_tree().get_nodes_in_group(PuzzleType):
		if children is Triggerable:
			puzzles.append(children)
			children.onTrigger.connect(puzzleSolved)

func puzzleSolved(puzzle : Triggerable):
	finishedPuzzles.append(puzzle)
	checkForFinishPuzzles()
	
func checkForFinishPuzzles():
	if(finishedPuzzles.size() == puzzles.size()):
		puzzleFinished.emit()
