extends PuzzleArea

func _ready():
	checkForPuzzles()
	
func checkForFinishPuzzles():
	if(finishedPuzzles.size() == puzzles.size()):
		GameManager.player.UI.MenuImages.PlayAnimation(func(): super.finishPuzzle())
		GameManager.cinematics.playDialogue(GameManager.cinematics.dialogo3)
