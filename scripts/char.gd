extends Node

var character
var revealed = false

func _process(delta):
	if revealed:
		self.texture = load("res://characters/"+character+".png")
	else:
		self.texture = load("res://characters/blank.png")