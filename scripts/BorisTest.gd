extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var testPots

# Called when the node enters the scene tree for the first time.
func _ready():
	testPots = get_node("Control")
	testPots.setItems(Items.r1Items)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
