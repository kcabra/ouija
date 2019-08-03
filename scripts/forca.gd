extends Node2D

onready var ouija = $chars # node whose childs are the clickable chars
onready var target_spaces = $blank # node whose childs are the blanks and discovered chars
var target: String = "sasa"

func _ready():
	for ch in target:
		add_blank(ch)

func add_blank(ch):
	var blank = TextureRect.new()
	blank.set_script(load("res://scripts/char.gd"))
	blank.character = ch
	target_spaces.add_child(blank)

func _input(event):
	if (event is InputEventMouseButton
			and event.button_index == BUTTON_LEFT
			and event.pressed == true):
		var mouse_pos = get_global_mouse_position()
		for ch in ouija.get_children():
			if ch.get_global_rect().has_point(mouse_pos):
				reveal(ch.name)

func reveal(ch):
	var missed = true
	for node in $blank.get_children():
		if node.character == ch:
			node.revealed = true
			missed = false
	if missed:
		print("errrooooouuuu")