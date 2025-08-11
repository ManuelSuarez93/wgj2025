extends Control

class_name MenuPause

@export_group("Options")
@export_subgroup("Volume Sliders")
@export var EffectVoulmeSlider : HSlider
@export var DialogueVolumeSlider : HSlider
@export var MusicSlider : HSlider

@export_group("Buttons")
@export var play_button : TextureButton
@export var quit_button : TextureButton

var sounds : Array[AudioStreamPlayer3D]
var playerSounds : AudioStreamPlayer
var music : AudioStreamPlayer
var dialogue : AudioStreamPlayer

func _ready():
	for audio in get_tree().get_nodes_in_group("Sound"):
		if audio is AudioStreamPlayer3D:
			sounds.append(audio)
		
	music = get_tree().get_first_node_in_group("Music")
	dialogue = get_tree().get_first_node_in_group("Dialogue")

	EffectVoulmeSlider.value_changed.connect(EffectVolumeSliderChanged)
	DialogueVolumeSlider.value_changed.connect(DialogueVolumeSliderChanged)
	MusicSlider.value_changed.connect(MusicVolumeSliderChanged)
	
	quit_button.pressed.connect(func(): get_tree().quit())
	play_button.pressed.connect(func():
		GameManager.UI.isOnMenu = false
		GameManager.UI.setMenuVisible(UIMenu.MenuType.None, false, true) 
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED))
	
func EffectVolumeSliderChanged(value : float):
	for sound in sounds:
		sound.volume_linear = value
		
func MusicVolumeSliderChanged(value : float):
	music.volume_linear = value

func DialogueVolumeSliderChanged(value : float):
	dialogue.volume_linear = value
