extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	print(Items.heldItem)
	if Items.heldItem:
		print(Items.heldItem.smell)
		match Items.heldItem.smell:
			Items.smells.GOOD:
				self.frame = 1
			Items.smells.BAD:
				self.frame = 3
			Items.smells.NEUTRAL:
				self.frame = 0
			Items.smells.CONFUSE:
				self.frame = 2
	else:
		self.frame = 0
	pass # Replace with function body.
