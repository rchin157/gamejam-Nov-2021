extends Area2D

var player = null

onready var globalData = get_node("")
var currentStep = -1
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
	if checkLastStepCompleted() or currentStep == -1:
		#if globalData.currentStep == globalData.lastStep:
			#show end of game dialogue
		#else:
		# give new hint
		currentStep = currentStep + 1
		#nextItem = globalData.getRequirement(currentStep)
		var option = rng.randi_range(0, 3)
		if option == 0:
			# simply ask by item name
			var dopt = rng.randi_range(0, 1)
			if dopt == 0:
				currentHint = "Go get a dash of %s" % "placeholder garbage"
				
			else:
				currentHint = "Procure %s. And make quick." % "placeholder garbage 2"
			say(currentHint)
		elif option == 1:
			# ask by description
			var dopt = rng.randi_range(0, 1)
			if dopt == 0:
				currentHint = "Go get a dash of... whatever that %s substance is, in the %s flask. %s %s I can't be foggled to remember the name." % ["insert colour", "insert_flask", "extra details sentence 1.", "extra details sentence 2."]
			else:
				currentHint = "Find some of that %s substance in the %s flask. %s %s You know the one. At least you should." % ["insert colour", "insert_flask", "extra details sentence 1.", "extra details sentence 2."]
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
	print("alchguy enter")
	area.setInteractable(self)
	player = area


func _on_AlchGuy_area_exited(area):
	print("alchguy exit")
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
