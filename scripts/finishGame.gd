extends Node2D

var particles
var onText = false
var recipe

# Called when the node enters the scene tree for the first time.
func _ready():
	Sfx.stopSongs()
	recipe = get_node("CanvasLayer/Recipe")
	particles = [get_node("CanvasLayer/Particles2D"),get_node("CanvasLayer/Particles2D2")]
	Sfx.enableSong(4)
	if Items.win:
		$CanvasLayer/AnimatedSprite.set_animation("Win")
	else:
		$CanvasLayer/AnimatedSprite.set_animation("Lose")
	$CanvasLayer/AnimatedSprite.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generateRecipe():
	var winText = "The Winning Recipe Was:\n"
	for i in range(Items.lastStep+1):
		winText = winText+Items.usedNames[Items.allVItems[i].ID]+",\n\n"
	winText = winText+"and finally...\n A Dash of Fulminate"
	#print(Items.lastStep)
	recipe.set_text(winText)
	recipe.show()

func toggleParticles(toggle):
	if toggle:
		particles[0].show()
		particles[1].show()
		generateRecipe()
	else:
		particles[0].hide()
		particles[1].hide()
		recipe.hide()
func _on_AnimatedSprite_animation_finished():
	$CanvasLayer/Button.show()


func _on_Button_pressed():
	if not onText:
		onText = true
		$CanvasLayer/ColorRect.show()
		if Items.win:
			toggleParticles(false)
			$CanvasLayer/ColorRect/wintext.show()
		else:
			$CanvasLayer/ColorRect/losetext.show()
	else:
		get_tree().change_scene("res://scenes/menu.tscn")


func _on_AnimatedSprite_frame_changed():
	if Items.win:
		if $CanvasLayer/AnimatedSprite.frame == 2:
			Sfx.stopSongs()
			toggleParticles(true)
			Sfx.enableSong(2)
			$CanvasLayer/AnimatedSprite.stop()
			$CanvasLayer/Button.show()
	else:
		if $CanvasLayer/AnimatedSprite.frame == 2:
			Sfx.stopSongs()
			Sfx.enableSong(3)
		if $CanvasLayer/AnimatedSprite.frame == 3:
			$CanvasLayer/AnimatedSprite.stop()
			$CanvasLayer/Button.show()
