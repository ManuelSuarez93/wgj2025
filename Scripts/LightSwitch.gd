extends Triggerable

@export var lights : Array[Light3D]
@export var interruptorOnAudio : AudioStream
@export var interruptorOffAudio : AudioStream
@export var audioPlayer : AudioStreamPlayer3D

func doTrigger(): 
	var turnOn = false
	for light in lights:
		light.visible = !light.visible
		turnOn = light.visible
	onTrigger.emit(self)
	
	if(turnOn):
		audioPlayer.stream = interruptorOnAudio
	else:
		audioPlayer.stream = interruptorOffAudio
	
	audioPlayer.play()
