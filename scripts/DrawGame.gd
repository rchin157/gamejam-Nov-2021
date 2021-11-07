extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var outer
var inner

const distcutoff = 20

var nodeSpawner = load("res://entities/MouseNode.tscn")

var mouseNode
var line

var mouseNodes = []
var mouseDraw = false
var drawing = false;

var firstNodePos
var lastNodePos

# Called when the node enters the scene tree for the first time.
func _ready():
	line = get_node("Line")
	outer = get_node("CircleTest/OuterShape")
	inner = get_node("CircleTest/InnerShape")
	mouseNode = get_node("MouseNode")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(mouseDraw):
		if drawing:
			checkNextNode()	
			checkReleased()
		else:
			checkMouseStart()
			
	pass
#	pass

func checkNextNode():
	var pos = get_viewport().get_mouse_position()-get_position()
	if lastNodePos.distance_to(pos)>=distcutoff:
		spawnNode()

func checkReleased():
	if Input.is_action_just_released("mouse"):
		print("released")
		drawing = false
		if not closedShape():
			purgeDrawing()
		else:
			checkShapeQuality()

func checkMouseStart():
	if Input.is_action_just_pressed("mouse"):
		print("pressed")
		spawnNode()
		firstNodePos = get_viewport().get_mouse_position()-get_position()
		drawing = true

func _on_ColorRect_mouse_entered():
	print("entered drawgame")
	mouseDraw = true
	pass # Replace with function body.

func closedShape():
	return firstNodePos.distance_to(lastNodePos)<=distcutoff*2
		
func checkShapeQuality():
	var failures = 0
	for i in range(mouseNodes.size()):
		if not mouseNodes[i].checkActive(inner,outer):
			failures+=1
	print("you have "+String(failures)+" failures")
func purgeDrawing():
	line.clear_points()
	for i in range(mouseNodes.size()):
		remove_child(mouseNodes[i])
	mouseNodes.clear()

func spawnNode():
	var node = nodeSpawner.instance()
	node.set_position(get_viewport().get_mouse_position()-get_position())
	add_child(node)
	mouseNodes.append(node)
	lastNodePos = node.get_position()
	line.add_point(node.get_position())

func _on_ColorRect_mouse_exited():
	print("exit drawgame")
	mouseDraw = false
	drawing = false
	purgeDrawing()
	pass # Replace with function body.
