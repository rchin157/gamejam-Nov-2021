extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var drawing
var player = null
var convoPoint = 0
var dialogue = ["How can I help you today? I can try to see if I have what you're looking for if you describe it for me.",
"Sorry I don't think I have something like that. Have you tried looking around a little more?",
"I can't understand what you're describing.",
"You want to try again?",
"Here! I think this is what you're looking for."]

# Called when the node enters the scene tree for the first time.
func _ready():
	drawing = get_node("CanvasLayer/Drawgame")
	drawing.setDrawDaddy(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func drawingPassed():
	var give = Items.allVItems[Items.currentStep]
	
	if checkValidItem(give):
		Items.changeHeld(give)
		say(dialogue[4])
		convoPoint = 2
	else:
		say(dialogue[1])
		convoPoint = 2
	pass
func drawingFailed():
	say(dialogue[2])
	convoPoint = 4
	pass

func startDrawing():
	drawing.set_visible(true)

func _on_Area2D_area_exited(area):
	area.get_parent().setInteractable(null)
	player = null
	pass # Replace with function body.

#validates that item is in suppliers pool
func checkValidItem(item):
	var id = item.ID
	for i in range(Items.r2Items.size()):
		if Items.r2Items[i].ID == id:
			return true
	return false

func interact():
	if convoPoint == 0:
		say(dialogue[0])
	else:
		say(dialogue[3])
	pass

func _on_Area2D_area_entered(area):
	area.get_parent().setInteractable(self)
	player = area.get_parent()
	pass # Replace with function body.

func hideText():
	$CanvasLayer/Dialogue.hide()
	
func say(lines):
	$CanvasLayer/Dialogue/Text.set_text(lines)
	$CanvasLayer/Dialogue.show()
	
func progressInteraction():
	if convoPoint == 0 or convoPoint == 3:
		convoPoint = 1
		startDrawing()
		hideText()
	if convoPoint == 2:
		convoPoint = 0
		hideText()
		player.finishInteraction()
	if convoPoint == 4:
		convoPoint = 3
		hideText()
		player.finishInteraction()
	pass
