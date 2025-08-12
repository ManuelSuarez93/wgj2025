extends UIMenu

class_name PictureMenu 

@export_category("FotosUI")
@export var FotosJuego : Control 
@export var FotosUI : Array[TextureRect]

@export_category("Tween")
@export var TweenDuration : float = 1
@export var CloseMenuWait : float = 1
@export_group("Fotos") 
@export var FotosAnimacion : Control
@export var Fotos : Array[TextureRect]
@export var PosicionFinalFotos : Array [Control]

var tween : Tween
 

func showPhoto(number : int, show : bool):
	FotosUI[number].visible = show

func PlayAnimation(callback : Callable):
	FotosJuego.visible = false
	FotosAnimacion.visible = true
	
	tween = create_tween()
	
	for i in range(Fotos.size()):
		var foto = Fotos[i]
		var final = PosicionFinalFotos[i]
		tween.tween_property(foto, "position", final.position, TweenDuration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	
	tween.tween_interval(CloseMenuWait)
	
	tween.tween_callback(func() :
		GameManager.UI.Picture_Menu.visible = false
		callback.call()
		)
	
	tween.play()
	
