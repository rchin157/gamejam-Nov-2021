extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Sfx.stopSongs()
	Sfx.enableSong(0)
	pass # Replace with function body.


func _on_Start_pressed():
	Items.gameStart()
	get_tree().change_scene("res://scenes/lab.tscn")


func _on_Instructions_pressed():
	$CanvasLayer/InstructionsPanel.show()


func _on_close_pressed():
	$CanvasLayer/InstructionsPanel.hide()
