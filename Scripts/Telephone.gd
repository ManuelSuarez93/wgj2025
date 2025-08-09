extends Triggerable

func doTrigger():
	GameManager.player.UI.SetMenuVisible(PlayerUI.Menu.Phone, true, false)
