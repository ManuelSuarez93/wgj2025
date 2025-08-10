extends Control

class_name MenuPicture 

@export var Fotos : Array[TextureRect]

func showPhoto(number : int, show : bool):
	Fotos[number].visible = show
