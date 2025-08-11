extends Triggerable

func _ready():
	GameManager.UI.Telephnone_Menu.onCallCorrect.connect(enable)

func doTrigger():
	if(canTrigger):
		GameManager.UI.setMenuVisible(UIMenu.MenuType.Phone, true, false)
