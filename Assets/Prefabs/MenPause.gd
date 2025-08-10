extends Control

class_name MenuPause

@export var EffectVoulmeSlider : HSlider
@export var DialogueVolumeSlider : HSlider
@export var MusicSlider : HSlider


var sounds : Array[AudioStreamPlayer3D]
var music : AudioStreamPlayer3D
var dialogue : AudioStreamPlayer3D

func _ready():
	for audio in get_tree().get_nodes_in_group("Sound"):
		if audio is AudioStreamPlayer3D:
			sounds.append(audio)
		
	music = get_tree().get_first_node_in_group("Music")
	dialogue = get_tree().get_first_node_in_group("Dialogue")

	EffectVoulmeSlider.value_changed.connect(EffectVolumeSliderChanged)
	DialogueVolumeSlider.value_changed.connect(DialogueVolumeSliderChanged)
	MusicSlider.value_changed.connect(MusicVolumeSliderChanged)
	
func EffectVolumeSliderChanged(value : float):
	for sound in sounds:
		sound.volume_linear = value
		
func MusicVolumeSliderChanged(value : float):
	music.volume_linear = value

func DialogueVolumeSliderChanged(value : float):
	dialogue.volume_linear = value
