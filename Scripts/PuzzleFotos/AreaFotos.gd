extends PuzzleArea

func _ready():
	checkForPuzzles()
	
func checkForFinishPuzzles():
	if(finishedPuzzles.size() == puzzles.size()):
		GameManager.UI.Picture_Menu.PlayAnimation(func(): 
			super.finishPuzzle()
			GameManager.Cinematics.playDialogue(GameManager.Cinematics.Dialogo3)
		)
