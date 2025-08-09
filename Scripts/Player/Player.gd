extends CharacterBody3D

# Configuración de movimiento
@export var speed = 5.0  
@export var mouse_sensitivity = 0.002
@export var camera : Node3D
@export var raycast : DetectObjectRaycast
@export var UI : PlayerUI

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	raycast.detectedObject.connect(UI.onDetectedObject)
	raycast.notDetecting.connect(UI.onNonDetectingObject)

func _input(event):
	cameraRotation(event)

func _physics_process(delta):
	move(delta)

func cameraRotation(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
		
func move(delta: float):
	# Aplicar gravedad
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Movimiento basado en input
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
