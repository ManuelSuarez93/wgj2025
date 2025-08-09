extends Area3D

class_name Triggerable

@export var MainPuzzleArea : PuzzleArea

signal onTrigger(Puzzle : Triggerable)

func doTrigger():
	onTrigger.emit(self)
