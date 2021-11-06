extends Area2D

var requiredSubstances = []
var currentSubstances = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# return true if the current substanes match the required substances
func verifyContents():
	for req in requiredSubstances:
		if not currentSubstances.has(req):
			return false
	return true
		
func addRequirement(req):
	requiredSubstances.append(req)
	
func addCurrent(curr):
	currentSubstances.append(curr)
