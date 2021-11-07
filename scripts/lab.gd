extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tables = []
var inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	Items.changeHeld(Items.heldItem)
	inventory = get_node("InventoryView")
	tables = [
		get_node("PotionTable"),
		get_node("PotionTable2"),
		get_node("PotionTable3"),
		get_node("PotionTable4"),
		get_node("PotionTable5"),
		get_node("PotionTable6")
	]
	if Items.playerHasLeft and not Items.reorganizeExplained:
		Items.reorganizeExplained = true
		$CanvasLayer/ColorRect.show()
		$Player.setInteracting(true)

	for i in range(tables.size()):
		tables[i].setDaddy(self)
		tables[i].tableStart = tables[i].tableContents*i
	
	if Items.previousRoom == 4:
		$Player.position = Vector2(148, 717)

func setPlayer(player):
	inventory.setPlayer(player)

func displayInventory(items):
	inventory.set_visible(true)
	inventory.clearItems()
	inventory.setItems(items)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_closePrompt_pressed():
	$CanvasLayer/ColorRect.hide()
	$Player.setInteracting(false)
