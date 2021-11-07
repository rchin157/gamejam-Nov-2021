extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var displayItem

# Called when the node enters the scene tree for the first time.
func _ready():
	displayItem = get_node("DetectItem")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	Sfx.playSFX(1)
	if Items.heldItem:
		showItem()
	else:
		removeItem()
	pass # Replace with function body.

func showItem():
	displayItem.set_visible(true)
	displayItem.setAppearance(Items.heldItem)
	match Items.heldItem.resonance:
			Items.resonances.NON:
				self.frame = 0
			Items.resonances.ANGLE:
				self.frame = 1
			Items.resonances.ERROR:
				self.frame = 3
			Items.resonances.SINE:
				self.frame = 2

func removeItem():
	self.frame = 0
	displayItem.set_visible(false)

func _on_Area2D_area_exited(area):
	removeItem()
	pass # Replace with function body.
