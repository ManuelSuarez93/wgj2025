extends CharacterBody3D

class_name PlayerChar

@export_category("Movement")
@export var speed = 5.0  
@export var mouse_sensitivity = 0.002
@export var camera : Node3D
@export_category("UI")
@export var raycast : DetectObjectRaycast 
@export_category("Audio")
@export var PlayerEffects : AudioStreamPlayer 
@export var AudioTimer : Timer
@export var StepsAudioPlayer : AudioStreamPlayer
@export var StepTimer : Timer
@export var Steps : Array[AudioStream]

var detectedObject : Triggerable
var enableMovement : bool 
var canPlaySound : bool
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

signal interacted

#region Godot Methods
func _ready(): 
	StepTimer.timeout.connect(playStep)
	enableMovement = false
	raycast.detectedObject.connect(GameManager.UI.onDetectedObject)
	raycast.notDetecting.connect(GameManager.UI.onNonDetectingObject)
	raycast.detectedObject.connect(saveDetectedObject)
	raycast.notDetecting.connect(removeDetectedObject)

func _input(event):
	if(enableMovement):
		cameraRotation(event)
	if event.is_action_pressed("interact") && detectedObject != null:
		interacted.emit()
		detectedObject.doTrigger()

func _physics_process(delta):
	if(enableMovement):
		move(delta)
#endregion

#region Interaction
func saveDetectedObject(collider):
	detectedObject = collider
	
func removeDetectedObject():
	detectedObject = null
	
func interact():
	GameManager.UI.interact()
	detectedObject.doTrigger()
#endregion

#region Character Movement
func cameraRotation(event):
	if GameManager.LevelStarted and event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
		
func move(delta: float):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	canPlaySound = input_dir.length() > 0
		
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()

func setEnableMovement(enable : bool):
	enableMovement = enable
	
#endregion

#region Sounds
func playEffectSounds(sound : AudioStream, startAt: float = 0, endAt : float =0):
	if(!AudioTimer.is_stopped()):
		AudioTimer.stop()
	
	if(endAt > 0):
		AudioTimer.wait_time = endAt 
		AudioTimer.timeout.connect(AudioTimer.stop) 
		
	PlayerEffects.stop()
	PlayerEffects.stream = sound
	PlayerEffects.play(startAt)
	
func playStep():
	print("starting the timer" + str(StepTimer.time_left))
	if(canPlaySound):
		StepTimer.start()
		StepsAudioPlayer.stream = Steps[RandomNumberGenerator.new().randi_range(0, Steps.size() - 1)]
		StepsAudioPlayer.play()
#endregion
