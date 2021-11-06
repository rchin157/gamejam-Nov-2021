extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Dialogue.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func interact():
	$Dialogue.show()
	if checkLastStepCompleted():
		# give new hint
		pass
	else:
		# tell them to fuck off
		pass


func _on_AlchGuy_area_entered(area):
	print("alchguy enter")
	area.setInteractable(self)


func _on_AlchGuy_area_exited(area):
	print("alchguy exit")
	area.setInteractable(null)

func checkLastStepCompleted():
	#check global script if anything has been added to a cauldron
	pass
