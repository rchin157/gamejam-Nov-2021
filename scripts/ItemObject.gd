extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var fill
var frame
var nameTag
var buttonListener = null
var button
var ref

# Called when the node enters the scene tree for the first time.
func _ready():
	fill = get_node("Fill")
	frame = get_node("Frame")
	nameTag = get_node("Name")
	button = get_node("Button")
	pass # Replace with function body.

func setAppearance(item):
	ref = item
	var s = item.shape
	var c = item.color
	var t = item.tint
	
	#enum smells {NEUTRAL,GOOD,BAD,CONFUSE}
	#enum colors {RED,BLUE,YELLOW,GREEN}
	#enum shapes {ERLENMEYER,FLORENCE,JAG,BOX}
	#enum shades {DARK,BRIGHT}
	var spriteFrame
	
	var dark = t == Items.shades.DARK
	
	nameTag.set_bbcode("[center]"+Items.usedNames[item.ID]+"[center]")
	
	match s:
		Items.shapes.ERLENMEYER:
			spriteFrame = 0
		Items.shapes.FLORENCE:
			spriteFrame = 1
		Items.shapes.JAG:
			spriteFrame = 2
		Items.shapes.BOX:
			spriteFrame = 3
	fill.frame = spriteFrame
	frame.frame = spriteFrame
	
	match c:
		Items.colors.RED:
			if dark:
				fill.set_modulate(Color(0.5,0,0))
			else:
				fill.set_modulate(Color(1,0,0))
		Items.colors.YELLOW:
			if dark:
				fill.set_modulate(Color(0.5,0.5,0))
			else:
				fill.set_modulate(Color(1,1,0))
		Items.colors.BLUE:
			if dark:
				fill.set_modulate(Color(0,0,0.5))
			else:
				fill.set_modulate(Color(0,0,1))
		Items.colors.GREEN:
			if dark:
				fill.set_modulate(Color(0,0.5,0))
			else:
				fill.set_modulate(Color(0,1,0))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func enableButton():
	button.set_visible(true)

func _on_Button_presser():
	Items.heldItem = ref
	pass # Replace with function body.
