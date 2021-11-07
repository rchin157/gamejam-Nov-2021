extends Area2D

export var speed = 20 # pixels per second
export var xPad = 50
export var yPad = 50
var screen_size



var interactable = null
var interacting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	if not interacting:
		if Input.is_action_pressed("ui_right"):
			velocity.x = 1
		if Input.is_action_pressed("ui_left"):
			velocity.x = -1
		if Input.is_action_pressed("ui_down"):
			velocity.y = 1
		if Input.is_action_pressed("ui_up"):
			velocity.y = -1
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			#$AnimatedSprite.play()
		else:
			#$AnimatedSprite.stop()
			pass
		position += velocity * delta
		position.x = clamp(position.x, xPad, screen_size.x - xPad)
		position.y = clamp(position.y, yPad, screen_size.y - yPad)
	
		# more animation stuff
		if velocity.x != 0:
			pass
			#$AnimatedSprite.animation = "walk"
			#$AnimatedSprite.flip_v = false
			#$AnimatedSprite.flip_h = velocity.x < 0
	
		if Input.is_action_just_pressed("ui_select") and interactable != null:
			interacting = true
			interactable.interact()
			print("interacted")
			
	else:
		if Input.is_action_just_pressed("ui_select"):
			# signal the interaction to progress or close
			interactable.progressInteraction()
			pass
	
func setHeldItem(item):
	Items.heldItem = item

func getHeltItem():
	return Items.heldItem

func dropItem():
	Items.heldItem = null

func setInteractable(inter):
	Items.interactable = inter

func finishInteraction():
	Items.interacting = false




