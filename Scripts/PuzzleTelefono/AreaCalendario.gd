extends PuzzleArea

@export_category("Interrutpor")
@export var CalendarioApagado : Node3D
@export var CalendarioPrendido : Node3D
@export var InterrutporApagado : Node3D
@export var InterruptorPrendido : Node3D
@export var Interruptor : Triggerable


func _ready():
	Interruptor.onTrigger.connect(onLightTurnedOn)
	GameManager.player.UI.MenuTelefono.onCallCorrect.connect(onCallCorrect)
	GameManager.player.UI.MenuTelefono.onCallWrong.connect(onCallWrong)
	
func onLightTurnedOn(trigger : Triggerable):
	var isVisible = CalendarioApagado.visible
	CalendarioApagado.visible = !isVisible
	CalendarioPrendido.visible = isVisible
	InterrutporApagado.visible = !isVisible
	InterruptorPrendido.visible = isVisible

func onCallCorrect():
	Door.open()

func onCallWrong():
	pass
