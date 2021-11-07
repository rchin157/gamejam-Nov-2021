extends Area2D

var player = null

var currentHint = ""

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	$Dialogue.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func interact():
	$Dialogue.show()
	if checkLastStepCompleted() or Items.currentStep == -1:
		if Items.currentStep == Items.lastStep:
			#show end of game dialogue
			say("Thats everything, go check the results.")
		else:
			# give new hint
			Items.currentStep = Items.currentStep + 1
			var nextItem = Items.getRequirement(Items.currentStep)
			var details = Items.getInfoStrings(nextItem)
			var option = rng.randi_range(0, 3)
			if option == 0:
				# simply ask by item name
				var dopt = rng.randi_range(0, 1)
				if dopt == 0:
					currentHint = "Go get a dash of %s" % details[4]
				else:
					currentHint = "Procure %s. And make quick." % details[4]
				say(currentHint)
			elif option == 1:
				# ask by description
				var dopt = rng.randi_range(0, 1)
				if dopt == 0:
					currentHint = "Go get a dash of... whatever that %s %s substance is, in the %s flask. It smells %s. I can't be foggled to remember the name." % [details[2], details[1], details[3], details[0]]
				else:
					currentHint = "Find some of that %s %s substance in the %s flask. Smells %s. You know the one. At least you should." % [details[2], details[1], details[3], details[0]]
				say(currentHint)
			else:
				# ask by alternate name
				var dopt = rng.randi_range(0, 1)
				if dopt == 0:
					currentHint = "Next is a dash of %s, or at least something similar. Go on then." % "insert bullshit name"
				else:
					currentHint = "A substance similar to %s. Go get it." % "insert bullshit name here"
				say(currentHint)
		
	else:
		# tell them to fuck off
		say("Didn't you hear me the first time? %s Get on with it." % currentHint)


func _on_AlchGuy_area_entered(area):
	#print("alchguy enter")
	area.setInteractable(self)
	player = area


func _on_AlchGuy_area_exited(area):
	#print("alchguy exit")
	area.setInteractable(null)
	player = null

func checkLastStepCompleted():
	#check global script if anything has been added to a cauldron
	pass

func say(lines):
	$Dialogue/Text.set_text(lines)
	$Dialogue.show()
	
func progressInteraction():
	$Dialogue.hide()
	player.finishInteraction()
