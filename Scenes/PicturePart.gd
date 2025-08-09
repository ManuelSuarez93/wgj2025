extends Triggerable

class_name PicturePart

@export var picturePartNumber : int
@export var image : Node3D
@export var pickupAudio : AudioStream 

signal picturePickedUp(number : int, show : bool)

func _ready():
	picturePickedUp.connect(GameManager.player.UI.MenuImages.showPhoto)
	
func doTrigger(): 
	onTrigger.emit(self)
	picturePickedUp.emit(picturePartNumber, true)
	GameManager.player.playSound(pickupAudio)
	queue_free()
