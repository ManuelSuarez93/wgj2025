extends Area3D


@export var affectedObject : Node3D


func on_body_entered(body: Node3D) -> void:
	affectedObject.visible = !affectedObject.visible
	print("se cambio")
