extends Area2D

var requiredSubstances = []
var currentSubstances = []

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$Particles2D.process_material.color = Items.potColour


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# return true if the current substanes match the required substances
func verifyContents():
	for req in requiredSubstances:
		if not currentSubstances.has(req):
			return false
	return true

func interact():
	if Items.heldItem != null:
		Items.addSubstance(Items.heldItem)
		$Particles2D.process_material.color = Items.potColour
		Items.changeHeld(null)
		player.finishInteraction()
	else:
		say("You don't have anything to add.")


func _on_Apparatus_area_entered(area):
	area.get_parent().setInteractable(self)
	player = area.get_parent()


func _on_Apparatus_area_exited(area):
	area.get_parent().setInteractable(null)
	player = null

func say(lines):
	$CanvasLayer/ColorRect/Text.set_text(lines)
	$CanvasLayer/ColorRect.show()
	
func progressInteraction():
	$CanvasLayer/ColorRect.hide()
	player.finishInteraction()
