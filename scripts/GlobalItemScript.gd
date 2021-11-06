extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#Defines the maximum items that can exist based on boolean properties
#Boolean order: Color>Shade>Shape>Smell
const maxItems = 64;
const itemBits = 6;
const sameSeed = false;

var itemList = [];

#Lists for storing items in use

var r1Items = [];
var r2Items = [];
var bItems = [];

var allItems =[];
var allVItems = [];

#enumerators for item properties
enum smells {NEUTRAL,GOOD,BAD,CONFUSE}
enum colors {RED,BLUE,YELLOW,GREEN}
enum shapes {ERLENMEYER,FLORENCE,JAG,BOX}
enum shades {DARK,BRIGHT}
#Compoenents for name generation

var prefix = ["Irradiated","Highly Innervated","Hydrogenated","Phosphorylated","Refined",
"Saturated","Filtered","Strained","Based","Fundamental","Nucleated","Freudian","Oedipal","Delicious",
"Supercooled","Distilled","Ultraviolet","Beta","Concentrated","Seeded","Feeded","Bugged","Logarithmic",
"Isotropic","Gram Blasted"]

var suffix = ["Ether","Ichor","Tofu","Benzoate","Aspic","Soylent","Talc","Mercury","Cinnabar","Quicksilver","Argentum",
"Ilnam","Sneedium","Chuckide","Susium","Glyceride","Alcohol","Sulfate","Yornce","Lewis","Oongul","Cope","Plasma","Sap"]

#Lists for all valid names and names in use dict

var itemNames = [];

var usedNames = {}

func gameStart():
	if !sameSeed:
		randomize();
	regenerateItemNames()
	regenerateNameDicts()
	regenerateItemList()
	
	populateList(r1Items,20)
	populateList(r2Items,10)
	populateList(bItems,10)
	compileAllItems()
	
	#This method is for debugging purposes
	
	

func debugItems():
	print(r1Items[0])
	print(r2Items[0])
	print(bItems[0])
	print(usedNames[r1Items[0].ID])
	print(usedNames[r2Items[0].ID])
	print(usedNames[bItems[0].ID])

func compileAllItems():
	allVItems.clear()
	allItems.clear()
	allVItems.append_array(r1Items)
	allVItems.append_array(r2Items)
	allItems.append_array(allVItems)
	allItems.append_array(bItems)
# Called when the node enters the scene tree for the first time.
func _ready():
	gameStart()
	debugItems()
	pass # Replace with function body.

func populateList(list,count):
	list.clear()
	list.resize(count)
	for i in range(count):
		list[i] = itemObject.new()
		list[i].defineProperties(itemList.pop_back())
		#creates a name in the dictionary for the item, add another one later for book if needed
		usedNames[list[i].ID] = itemNames.pop_back()
	if itemList.empty():
		print("not enough Item templates, list is empty")

func regenerateItemNames():
	itemNames.clear()
	var mNames = prefix.size()*suffix.size();
	var pSize = prefix.size()
	var sSize = suffix.size()
	itemNames.resize(mNames)
	for i in range(pSize):
		for j in range(sSize):
			itemNames[i+j*pSize] = prefix[i]+" "+suffix[j]
	
	itemNames.shuffle()
		
func regenerateNameDicts():
	usedNames.clear()


func regenerateItemList():
	itemList.clear()
	itemList.resize(maxItems)
	
	for i in range(maxItems):
		itemList[i]=i
	
	itemList.shuffle()
	pass



#Class for storing item properties
class itemObject:
	var smell
	var color
	var tint
	var shape
	var ID
	
	#Reward for shittiest code goes here
	func defineProperties(value):
		ID = value
		var binaries = getBinary(value)
		match binaries[0]:
			0:
				smell = smells.NEUTRAL
			1:
				smell = smells.GOOD
		match binaries[1]:
			0:
				tint = shades.DARK
			1:
				tint = shades.BRIGHT
		match binaries[2]+binaries[3]*2:
			0:
				color = colors.RED
			1:
				color = colors.GREEN
			2: 
				color = colors.YELLOW
			3: 
				color = colors.BLUE
				#enum shapes {ERLENMEYER,FLORENCE,JAG,BOX}
		match binaries[4]+binaries[5]*2:
			0:
				shape = shapes.ERLENMEYER
			1:
				shape = shapes.FLORENCE
			2: 
				shape = shapes.JAG
			3: 
				shape = shapes.BOX	
		pass
	
	func getBinary(number):
		var ret = []
		ret.resize(itemBits)
		for i in range(itemBits):
			ret[i] = number%2
			number = number/2
		return ret
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
