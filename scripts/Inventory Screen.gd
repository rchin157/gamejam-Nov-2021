extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var notify
var itemList = []
var itemSpawn = load("res://entities/ItemObject.tscn")
var scrollWindow
var itemLocation
const xoffset = 100
const yoffset = 100
const xint = 250


# Called when the node enters the scene tree for the first time.
func _ready():
	scrollWindow = get_node("ColorRect/ScrollContainer/ItemContainer")
	itemLocation = get_node("ColorRect/ScrollContainer/ItemContainer")
	pass # Replace with function body.

func clearItems():
	for i in range(itemList.size()):
		itemLocation.remove_child(itemList[i])
	itemList.clear()

func setPlayer(player):
	notify = player

func setItems(list):
	for i in range(list.size()):
		var spawn = itemSpawn.instance()
		itemList.append(spawn)
		itemLocation.add_child(spawn)
		spawn.setAppearance(list[i])
		spawn.enableButton()
		spawn.set_position(Vector2(xoffset,yoffset+i*xint))
	scrollWindow.set_custom_minimum_size(Vector2(400,list.size()*250+100))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	set_visible(false)
	clearItems()
	notify.finishInteraction()
	pass # Replace with function body.
