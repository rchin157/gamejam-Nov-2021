extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var body
var radius
var sprite
var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	body = get_node("MouseDrawNode/Body")
	radius = get_node("MouseDrawNode/Radius")
	sprite = get_node("Sprite")
	pass # Replace with function body.

func checkActive(smallArea,bigArea):
	if radius.overlaps_area(bigArea) and not body.overlaps_area(smallArea):
		active = true
		sprite.set_visible(true)
		return true
	else:
		active = false
		sprite.set_visible(false) 
		return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
