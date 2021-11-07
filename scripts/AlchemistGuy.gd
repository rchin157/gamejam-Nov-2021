extends Area2D

var player = null

var currentHint = ""

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	$CanvasLayer/Dialogue.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func interact():
	$CanvasLayer/Dialogue.show()
	if Items.ingredientAdded or Items.currentStep == -1:
		if Items.currentStep == Items.lastStep:
			#show end of game dialogue
			say("Thats everything, finish it off with a dash of this fulminate.")
			Items.changeHeld(Items.fulminate)
		else:
			# give new hint
			Items.ingredientAdded = false
			var nextItem = Items.getRequirement(Items.currentStep)
			var details = Items.getInfoStrings(nextItem)
			var option = rng.randi_range(0, 3)
			if option == 0:
				# simply ask by item name
				var dopt = rng.randi_range(0, 1)
				if dopt == 0:
					currentHint = "Go get a dash of %s and put it in the pot" % details[4]
				else:
					currentHint = "Procure %s. And make quick." % details[4]
				say(currentHint)
			elif option == 1:
				# ask by description
				var dopt = rng.randi_range(0, 1)
				if dopt == 0:
					currentHint = "Go get a dash of... whatever that %s %s substance is, in the %s flask. It smells %s and the resonance should be %s. I can't be foggled to remember the name." % [details[2], details[1], details[3], details[0], details[5]]
				else:
					currentHint = "Add some of that %s %s substance in the %s flask to the alembic. Smells %s and has %s resonance. You know the one. At least you should." % [details[2], details[1], details[3], details[0], details[5]]
				say(currentHint)
			else:
				# ask by alternate name
				var dopt = rng.randi_range(0, 1)
				if dopt == 0:
					currentHint = "Next is a dash of %s, or at least something similar. Go on then." % Items.bookNames[nextItem.ID]
				else:
					currentHint = "A substance similar to %s. Go add it to the alchemic apparatus." % Items.bookNames[nextItem.ID]
				say(currentHint)
		
	else:
		# tell them to fuck off
		say("Didn't you hear me the first time? %s Hurry up and put a dash into the cauldron." % currentHint)


func _on_AlchGuy_area_entered(area):
	#print("alchguy enter")
	area.get_parent().setInteractable(self)
	player = area.get_parent()


func _on_AlchGuy_area_exited(area):
	#print("alchguy exit")
	area.get_parent().setInteractable(null)
	player = null

func checkLastStepCompleted():
	#check global script if anything has been added to a cauldron
	pass

func say(lines):
	$CanvasLayer/Dialogue/Text.set_text(lines)
	$CanvasLayer/Dialogue.show()
	
func progressInteraction():
	$CanvasLayer/Dialogue.hide()
	player.finishInteraction()
