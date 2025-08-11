extends Triggerable

func doTrigger():
	GameManager.UI.setMenuVisible(UIMenu.MenuType.Hangman, true, false)
