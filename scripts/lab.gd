extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Items.previousRoom == 4:
		$Player.position = Vector2(148, 717)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
