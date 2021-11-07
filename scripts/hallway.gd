extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Items.previousRoom == 0:
		$Player.position = Vector2(1528, 474)
	elif Items.previousRoom == 1:
		$Player.position = Vector2(112, 474)
	elif Items.previousRoom == 2:
		$Player.position = Vector2(768, 474)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
