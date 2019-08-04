extends AudioStreamPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	stream = load("res://soundtrack/background.wav")
	play()
	connect("finished", self, "replay")
	
func replay():
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
