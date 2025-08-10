extends Area3D

class_name Triggerable

@export var MainPuzzleArea : PuzzleArea
@export var canTrigger : bool  = true

signal onTrigger(Puzzle : Triggerable)

func enable(enable : bool):
	canTrigger = enable

func doTrigger():
	if(canTrigger):
		onTrigger.emit(self)
