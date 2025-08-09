extends Triggerable

@export var lights : Array[Light3D]

func doTrigger():
	for light in lights:
		light.visible = !light.visible
		onTrigger.emit(self)
