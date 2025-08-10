extends Control

class_name MenuPicture 

@export var Fotos : Array[TextureRect]
@export var PosicionFinalFotos : Array [Control]

@export_category("Tween")
@export var TweenDuration : float = 1
@export var CloseMenuWait : float = 1

var tween : Tween
 
	
func showPhoto(number : int, show : bool):
	Fotos[number].visible = show
	checkAllPhotosCollected()

func checkAllPhotosCollected():
	var fotosVisibles = 0
	for foto in Fotos:
		if foto.visible == true:
			fotosVisibles += 1
	
	if(fotosVisibles == Fotos.size()):
		PlayAnimation()

func PlayAnimation():
	tween = create_tween()
	for i in range(Fotos.size()):
		var foto = Fotos[i]
		var final = PosicionFinalFotos[i]
		tween.tween_property(foto, "position", final.position, TweenDuration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	tween.tween_interval(CloseMenuWait)
	tween.tween_callback(func() : GameManager.player.UI.MenuImages.visible = false)
	tween.play()
	
