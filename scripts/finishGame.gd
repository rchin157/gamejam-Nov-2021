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
	if not onText:
		onText = true
		$CanvasLayer/ColorRect.show()
		if Items.win:
			$CanvasLayer/ColorRect/wintext.show()
		else:
			$CanvasLayer/ColorRect/losetext.show()
	else:
		get_tree().change_scene("res://scenes/menu.tscn")


func _on_AnimatedSprite_frame_changed():
	if Items.win:
		if $CanvasLayer/AnimatedSprite.frame == 2:
			$CanvasLayer/Button.show()
	else:
		if $CanvasLayer/AnimatedSprite.frame == 3:
			$CanvasLayer/Button.show()
