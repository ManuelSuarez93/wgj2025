extends Triggerable

func _ready():
	GameManager.player.UI.MenuTelefono.onCallCorrect.connect(enable)

func doTrigger():
	if(canTrigger):
		GameManager.player.UI.SetMenuVisible(PlayerUI.Menu.Phone, true, false)
