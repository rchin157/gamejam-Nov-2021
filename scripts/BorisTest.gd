extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var testPots

# Called when the node enters the scene tree for the first time.
func _ready():
	testPots = [get_node("Item"),get_node("Item2"),get_node("Item3"),get_node("Item4"),get_node("Item5"),
	get_node("Item6"),get_node("Item7"),get_node("Item8"),get_node("Item9"),get_node("Item10")]
	for i in range(testPots.size()):
		testPots[i].setAppearance(Items.r1Items[i])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
