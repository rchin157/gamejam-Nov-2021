extends Node2D

var onText = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if Items.win:
		$CanvasLayer/AnimatedSprite.set_animation("Win")
	else:
		$CanvasLayer/AnimatedSprite.set_animation("Lose")
	$CanvasLayer/AnimatedSprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	$CanvasLayer/Button.show()


func _on_Button_pressed():
	if Items.win:
		if not onText:
			onText = true
			$CanvasLayer/ColorRect.show()
		else:
			get_tree().change_scene("res://scenes/lab.tscn")
	else:
		get_tree().change_scene("res://scenes/lab.tscn")
