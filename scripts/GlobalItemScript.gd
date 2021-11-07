extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#Defines the maximum items that can exist based on boolean properties
#Boolean order: Color>Shade>Shape>Smell
const maxItems = 512;
const itemBits = 9;
const sameSeed = false;

var itemList = [];

#Lists for storing items in use

var r1Items = [];
var r2Items = [];
var bItems = [];

var allItems = [];
var allVItems = [];

# recipe progress tracking
var currentStep = -1
var lastStep
var rng = RandomNumberGenerator.new()

# room change stuff
# 0 = lab, 1 = supply, 2 = apparatus
var previousRoom = 0
var currentRoom = 0

#enumerators for item properties
enum resonances {NON,ANGLE,SINE,ERROR}
enum smells {NEUTRAL,GOOD,BAD,CONFUSE}
enum colors {RED,BLUE,YELLOW,GREEN}
enum shapes {ERLENMEYER,FLORENCE,JAG,BOX}
enum shades {DARK,BRIGHT}
#Compoenents for name generation

var prefix2 = ["Very","Partially","Significantly","Neglibly","Mostly","Slightly","Mildly","Fancy","Lukewarm","Boiling","Epic","Un-Epic",""
,"Unremarkable","2%","Old","Big","The","Potentially","Gigantic","Relevantly","Bootleg","Illegal","Verifiably","Irreparably"
,"Unfathomably","Cursed","Holy","Cozy","Especially"]

var prefix = ["Irradiated","Highly Innervated","Hydrogenated","Phosphorylated","Refined","Fragile","Suspiscious","Peculiar","Aerobic",
"Saturated","Filtered","Strained","Based","Fundamental","Nucleated","Freudian","Oedipal","Delicious","Broken","Whimsical","Acidic",
"Supercooled","Distilled","Ultraviolet","Beta","Concentrated","Seeded","Feeded","Bugged","Logarithmic","Alpha","Kino","Redeemed",
"Isotropic","Gram Blasted","Diluted","Infinite","Homogenized","Recrystallized","Fermented","Elastic","Superheated","Chiral","Achiral",
"German-Import","Seething","Friendly","Dwarven","Allopatric","Pickled","Contagious","Viral","Pathetic","Flaccid","Moist","Turgid",
"Flammable","Inflammable","Ductile","Malleable","Volatile","Fuming","Impartial","Inelastic","Rigid","Oxidized","Reduced","Polar","Malicious",
"Carcinogenic","Exorcised","Dissociated","Thick","Devious","Questionable",""]

var suffix = ["Ether","Ichor","Tofu","Benzoate","Aspic","Soylent","Talc","Mercury","Cinnabar","Quicksilver","Argentum","Banium","Wire","Kino",
"Ilnam","Sneedium","Chuckide","Susium","Glyceride","Alcohol","Sulfate","Yornce","Lewis","Oongul","Cope","Plasma","Sap","Love","Pheromone",
"青い","緑","Milk","Jaffa Cake","Bile","Salt","Brine","Water","Paste","Rick","Moonshine","Substance","Diamond","Budder","Bazinga"]

#Lists for all valid names and names in use dict

var itemNames = [];

var usedNames = {}
var bookNames = {}


#player item value
var heldItem = null

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
	
	lastStep = rng.randi_range(1, 20)
	allVItems.shuffle()
	

#This method is for debugging purposes
func debugItems():
	print(r1Items[0])
	print(r2Items[0])
	print(bItems[0])
	print(usedNames[r1Items[0].ID])
	print(usedNames[r2Items[0].ID])
	print(usedNames[bItems[0].ID])
	heldItem = r2Items[0]

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
		bookNames[list[i].ID] = itemNames.pop_back()
	if itemList.empty():
		print("not enough Item templates, list is empty")

func regenerateItemNames():
	itemNames.clear()
	var mNames = prefix.size()*suffix.size()*prefix2.size();
	print(mNames)
	var p2Size = prefix2.size()
	var pSize = prefix.size()
	var sSize = suffix.size()
	itemNames.resize(mNames)
	for i in range(pSize):
		for j in range(sSize):
			for k in range(p2Size):
				itemNames[i+j*pSize+k*pSize*sSize] = prefix2[k]+" "+prefix[i]+" "+suffix[j]
	
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
	var resonance
	var smell
	var color
	var tint
	var shape
	var ID
	
	#Reward for shittiest code goes here
	func defineProperties(value):
		ID = value
		var binaries = getBinary(value)
		match binaries[0]+binaries[1]*2:
			0:
				smell = smells.NEUTRAL
			1:
				smell = smells.GOOD
			2:
				smell = smells.BAD
			3:
				smell = smells.CONFUSE
		match binaries[2]:
			0:
				tint = shades.DARK
			1:
				tint = shades.BRIGHT
		match binaries[3]+binaries[4]*2:
			0:
				color = colors.RED
			1:
				color = colors.GREEN
			2: 
				color = colors.YELLOW
			3: 
				color = colors.BLUE
				#enum shapes {ERLENMEYER,FLORENCE,JAG,BOX}
		match binaries[5]+binaries[6]*2:
			0:
				shape = shapes.ERLENMEYER
			1:
				shape = shapes.FLORENCE
			2: 
				shape = shapes.JAG
			3: 
				shape = shapes.BOX	
				#enum resonance {NON,ANGLE,SINE,ERROR}
		match binaries[7]+2*binaries[8]:
			0:
				resonance = resonances.NON
			1:
				resonance = resonances.ANGLE
			2:
				resonance = resonances.SINE
			3:
				resonance = resonances.ERROR
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

func getRequirement(step):
	return allVItems[step]

# smell = 0, color = 1, shade = 2, shape = 3, name = 4
func getInfoStrings(item):
	var results = []
	match item.smell:
		smells.NEUTRAL:
			results.append("neutral")
		smells.GOOD:
			results.append("pleasant")
		smells.CONFUSE:
			results.append("odd")
		smells.BAD:
			results.append("something awful")
	match item.color:
		colors.BLUE:
			results.append("sapphire")
		colors.GREEN:
			results.append("viridescent")
		colors.RED:
			results.append("vermillion")
		colors.YELLOW:
			results.append("butter like")
	match item.tint:
		shades.BRIGHT:
			results.append("bright")
		shades.DARK:
			results.append("dark")
	match item.shape:
		shapes.BOX:
			results.append("boxy")
		shapes.ERLENMEYER:
			results.append("erlenmeyer")
		shapes.FLORENCE:
			results.append("florence")
		shapes.JAG:
			results.append("jagged")
	results.append(usedNames[item.ID])
	match item.resonance:
		resonances.ANGLE:
			results.append("angular")
		resonances.ERROR:
			results.append("immeasurable")
		resonances.NON:
			results.append("non-resonant")
		resonances.SINE:
			results.append("sinusoidal")
	return results





























