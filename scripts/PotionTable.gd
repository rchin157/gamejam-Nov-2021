extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const tableContents = 16
var tableStart = 0
var daddy
var player 
var itemDisplay

# Called when the node enters the scene tree for the first time.
func _ready():
	itemDisplay = get_node("DisplayItem")
	itemDisplay.nameTag.hide()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setStart(start):
	tableStart = start
	itemDisplay.setAppearance(Items.r1Items[tableStart])

func setDaddy(dad):
	daddy = dad

func progressInteraction():
	pass

func interact():
	var items = []
	items.resize(tableContents)
	for i in range(items.size()):
		items[i]=Items.r1Items[tableStart+i]
	daddy.displayInventory(items)
	daddy.setPlayer(player.get_parent())

func _on_Area2D_area_entered(area):
	area.get_parent().setInteractable(self)
	player = area
	pass # Replace with function body.


func _on_Area2D_area_exited(area):
	#print("alchguy exit")
	area.get_parent().setInteractable(null)
	player = null

	pass # Replace with function body.
