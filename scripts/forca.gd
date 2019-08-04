extends Node2D

onready var ouija = $keyboard # node whose childs are the clickable chars
onready var target_spaces = $blank # node whose childs are the blanks and discovered chars
onready var speak = $speak
var target: String
var tip: String

var hp = 5
var tip_counter = 3

func _ready():
	clear_scene()
	if not target == "nunca-mais":
		for i in range(target.length()):
			var letter_size = Vector2(25, 35)
			var ch = target[i]
			var blank = Sprite.new()
			blank.set_script(load("res://scripts/char.gd"))
			blank.character = ch
			var total_size = letter_size.x * target.length()
			blank.scale = Vector2.ONE / 4
			blank.position = Vector2(-total_size/2, 0) + Vector2(letter_size.x, 0)*i
			target_spaces.add_child(blank)
	else:
		for i in range(target.length()):
			var escala = 6
			var letter_size = Vector2(100, 140) / escala
			var ch = target[i]
			if ch == "-":
				continue
			var blank = Sprite.new()
			blank.set_script(load("res://scripts/char.gd"))
			blank.character = ch
			var total_size = letter_size.x * target.length()
			blank.scale = Vector2.ONE / escala
			blank.position = Vector2(-total_size/2, 0) + Vector2(letter_size.x, 0)*i
			target_spaces.add_child(blank)

func reveal(node):
	var ch = node.name
	node.modulate.a = 0.5
	var missed = true
	for node in $blank.get_children():
		if node.character == ch:
			node.revealed = true
			missed = false
	if missed:
		hp -= 1
		tip_counter -= 1
		if tip_counter == 0 or hp <= 2:
			speak.visible = true
			speak.get_node("Label").text = tip
			speak.get_node("Timer").start()
			tip_counter -= 1
		if hp == 0: # check loss
			print("lost")
	# check victory
	var won = true
	for child in target_spaces.get_children():
		if not child.revealed:
			won = false
			break
	if won:
		hp += 1
		get_parent().get_next_monster()

func clear_scene():
	tip_counter = 3
	for child in ouija.get_children():
		child.modulate.a = 1
	for child in target_spaces.get_children():
		child.queue_free()
