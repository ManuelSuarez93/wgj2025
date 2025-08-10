extends PuzzleArea

func _ready():
	checkForPuzzles()

func checkForFinishPuzzles():
	GameManager.player.UI.SetMenuVisible(PlayerUI.Menu.GameOver, true, false)
