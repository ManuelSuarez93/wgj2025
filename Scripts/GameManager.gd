extends Node3D

var player : Player

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	

func OpenMenuHangman():
	player.UI.SetMenuHangmanVisible()
