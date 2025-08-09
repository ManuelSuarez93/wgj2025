extends Triggerable

func doTrigger():
	GameManager.player.UI.SetMenuVisible(PlayerUI.Menu.Hangman, true, false)
