extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var musicArray
var syncMusic = [2,6,11]
var sfxArray
var enemyCount= 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	musicArray = [
		get_node("OpeningMenu"),
		get_node("MainTheme"),
		get_node("WinScreen"),
		get_node("LoseScreen"),
		get_node("PreVictorySong")
	]
	
	sfxArray = [
		get_node("BRAPP"),
		get_node("Resonator"),
	]
	
	pass # Replace with function body.

func playSFX(index:int):
	sfxArray[index].play(0)
	
func stopSFX(index):
	sfxArray[index].stop()

func enableSong(index: int):
	musicArray[index].play(musicArray[1].get_playback_position())
	
func stopSong(index: int):
	musicArray[index].stop();
	
func stopSongs():
	for i in range(musicArray.size()):
		musicArray[i].stop()	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
