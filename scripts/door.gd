extends Area2D

export var dest = 0
export var src = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Door_area_entered(area):
	Items.currentRoom = dest
	Items.previousRoom = src
	if src == 0:
		Items.playerHasLeft = true
	if dest == 0:
		get_tree().change_scene("res://scenes/lab.tscn")
	elif dest == 1:
		get_tree().change_scene("res://scenes/supplier.tscn")
	elif dest == 2:
		get_tree().change_scene("res://scenes/apparatusRoom.tscn")
	elif dest == 4:
		get_tree().change_scene("res://scenes/hallway.tscn")
