extends RayCast3D

class_name DetectObjectRaycast

signal detectedObject(collider)
signal notDetecting

func _physics_process(delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		if collider is Triggerable:
			detectedObject.emit(collider)
	else:
		notDetecting.emit()
		
