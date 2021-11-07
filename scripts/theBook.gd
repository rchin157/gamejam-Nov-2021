extends Area2D

var player = null
var page = 0

var item1 = null
var item2 = null

var rng = RandomNumberGenerator.new()

var totalPages = 0
var pC

var sentences = ["化学結合。 ", "煉金術是中世纪的一种化学哲学的思想和始祖，是当代化学的雏形。 ", "其目标是通過化學方法将一些基本金属转变为黃金，制造万灵药及制备长生不老药。 ", 
	"现在的科学表明这种方法是行不通的。 ", "但是直到~世纪之前，煉金術尚未被科学证据所否定。 ", "包括艾萨克·牛顿在内的一些著名科学家都曾进行过煉金術尝试。 ", "現代化学的出现才使人们对煉金術的可能性产生了怀疑。 ", 
	"西方的鍊金術。 ", "早期的鍊金術者的生活时代是从公元1世纪到5世纪。 ", "複数の物質に混合。 "]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$booklayer/book.hide()
	$booklayer/book/HBoxContainer/left/HBoxContainer/Panel/Item/Name.hide()
	$booklayer/book/HBoxContainer/right/HBoxContainer/Panel/Item/Name.hide()
	totalPages = int(ceil(Items.allItems.size() / 2))
	rng.randomize()
	#print(totalPages)
	#print(int(ceil(Items.allItems.size() / 2)))


func _on_Book_area_entered(area):
	area.get_parent().setInteractable(self)
	player = area.get_parent()


func _on_Book_area_exited(area):
	area.get_parent().setInteractable(null)
	player = null

func interact():
	$booklayer/PageCount.show()
	$booklayer/book.show()
	$booklayer/Button.show()
	$booklayer/PageCount.set_text(String(page+1)+"/"+String(totalPages))
	$booklayer/tip.show()
	loadPgs()

func progressInteraction():
	$booklayer/book/HBoxContainer/left/HBoxContainer/Panel/Item.hide()
	$booklayer/book/HBoxContainer/right/HBoxContainer/Panel/Item.hide()
	$booklayer/book/HBoxContainer/left/HBoxContainer/details.set_text("")
	$booklayer/book/HBoxContainer/right/HBoxContainer/details.set_text("")
	$booklayer/book/HBoxContainer/left/descr.set_text("")
	$booklayer/book/HBoxContainer/right/descr.set_text("")
	page = page + 1
	$booklayer/PageCount.set_text(String(page+1)+"/"+String(totalPages))
	if page > totalPages - 1:
		page = 0
		$booklayer/PageCount.hide()
		$booklayer/book.hide()
		$booklayer/Button.hide()
		$booklayer/tip.hide()
		player.finishInteraction()
	loadPgs()


func _on_Button_pressed():
	page = 0
	$booklayer/PageCount.hide()
	$booklayer/book.hide()
	$booklayer/Button.hide()
	$booklayer/tip.hide()
	player.finishInteraction()

func loadPgs():
	#print("item %s and %s" % [page * 2, page * 2 + 1])
	item1 = Items.allItems[page * 2]
	var details1 = Items.getInfoStrings(item1)
	$booklayer/book/HBoxContainer/left/name.set_text(Items.bookNames[item1.ID])
	$booklayer/book/HBoxContainer/left/HBoxContainer/Panel/Item.setAppearance(item1)
	$booklayer/book/HBoxContainer/left/HBoxContainer/details.set_text("Colour: %s\nShade: %s\nSmell: %s\nFlask: %s\nResonance: %s" % [details1[1], details1[2], details1[0], details1[3], details1[5]])
	$booklayer/book/HBoxContainer/left/descr.set_text(generateDescr())
	$booklayer/book/HBoxContainer/left/HBoxContainer/Panel/Item.show()
	
	if (page * 2) + 1 < Items.allItems.size():
		item2 = Items.allItems[(page * 2) + 1]
		var details2 = Items.getInfoStrings(item2)
		$booklayer/book/HBoxContainer/right/name.set_text(Items.bookNames[item2.ID])
		$booklayer/book/HBoxContainer/right/HBoxContainer/Panel/Item.setAppearance(item2)
		$booklayer/book/HBoxContainer/right/HBoxContainer/details.set_text("Colour: %s\nShade: %s\nSmell: %s\nFlask: %s\nResonance: %s" % [details2[1], details2[2], details2[0], details2[3], details2[5]])
		$booklayer/book/HBoxContainer/right/descr.set_text(generateDescr())
		$booklayer/book/HBoxContainer/right/HBoxContainer/Panel/Item.show()
	
func generateDescr():
	var result = ""
	sentences.shuffle()
	var numSents = rng.randi_range(2, sentences.size())
	for i in range(numSents):
		result = result + sentences[i]
	#print(result)
	return result





















