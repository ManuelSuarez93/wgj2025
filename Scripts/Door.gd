extends Area3D

class_name Door

@export var CollisionShape : CollisionShape3D

@export_category("Tween")
@export var TweenRotation : Vector3
@export var TweenDuration : float 

@export_category("Audio")
@export var Audio : AudioStream

var tween : Tween

func open():
	tween = create_tween()
	tween.tween_property(self, "rotation", rotation + TweenRotation, TweenDuration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.play()
