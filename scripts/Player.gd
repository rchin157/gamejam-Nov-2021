extends KinematicBody2D

export var speed = 20 # pixels per second
var screen_size

var velocity = Vector2()

var interactable = null
var interacting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Items.connect("heldSwitched",self,"_signalCaught")
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not interacting:
		if Input.is_action_just_pressed("ui_select") and interactable != null:
			interacting = true
			interactable.interact()
			#print("interacted")
	else:
		if Input.is_action_just_pressed("ui_select") and interactable != null:
			# signal the interaction to progress or close
			interactable.progressInteraction()

func _physics_process(delta):
	if not interacting:
		getInput()
		move_and_slide(velocity)
		velocity = Vector2(0,0)

func _signalCaught():
	#print("Seeded")
	updateItemDisplay(Items.heldItem)

func updateItemDisplay(item):
	if item != null:
		$CanvasLayer/Item.setAppearance(item)
		$CanvasLayer/Item.show()
	else:
		$CanvasLayer/Item.hide()

func setHeldItem(item):
	updateItemDisplay(item)
	Items.heldItem = item

func getHeltItem():
	return Items.heldItem

func dropItem():
	Items.heldItem = null

func setInteractable(inter):
	interactable = inter
	if inter != null:
		$interactPrompt.show()
	else:
		$interactPrompt.hide()

func finishInteraction():
	interacting = false

func getInput():
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
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite.set_frame(0)

	# more animation stuff
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0

func setInteracting(inter):
	interacting = inter


