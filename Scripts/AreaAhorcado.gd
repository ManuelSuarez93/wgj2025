extends PuzzleArea

func _ready():
	checkForPuzzles()

func checkForFinishPuzzles():
	GameManager.UI.setMenuVisible(UIMenu.MenuType.GameOver, true, false)
