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
	
func PlayAnimation(callback : Callable):
	tween = create_tween()
	for i in range(Fotos.size()):
		var foto = Fotos[i]
		var final = PosicionFinalFotos[i]
		tween.tween_property(foto, "position", final.position, TweenDuration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	tween.tween_interval(CloseMenuWait)
	tween.tween_callback(func() : 
		print("LA PUTA MADRE QUE LOS PARIO")
		GameManager.player.UI.MenuImages.visible = false
		callback.call()
		)
	
	tween.play()
	
