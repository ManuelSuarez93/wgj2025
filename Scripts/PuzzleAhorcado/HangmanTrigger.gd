extends Triggerable

func _ready():
	GameManager.Cinematics.Ahorcado.puzzleFinished.connect(func() : canTrigger = false)
	
func doTrigger():
	if canTrigger: 
		GameManager.UI.setMenuVisible(UIMenu.MenuType.Hangman, true, false)
