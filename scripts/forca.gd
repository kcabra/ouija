extends Node2D

onready var ouija = $keyboard # node whose childs are the clickable chars
onready var target_spaces = $blank # node whose childs are the blanks and discovered chars
onready var speak = $speak
onready var sfx_erro = $erro
var target: String
var tip: String

var hp = 5
var tip_shown = false

func _ready():
	randomize()
	clear_scene()
	if target == "nunca-mais" or target == "aracnofobia":
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
	else:
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

func reveal(node):
	var ch = node.name
	node.modulate.a = 0.5
	var missed = true
	for node in $blank.get_children():
		if node.character == ch:
			node.revealed = true
			missed = false
	if missed:
		hit()
	# check victory
	var won = true
	for child in target_spaces.get_children():
		if not child.revealed:
			won = false
			break
	if won:
		get_parent().get_next_monster()

func hit():
	var error = String(randi() % 2)
	sfx_erro.stream = load("res://soundtrack/erro"+error+".wav")
	sfx_erro.play()
	hp -= 1
	if hp < 3 and tip_shown == false:
		speak.speak(tip)
		tip_shown = true
	if hp == 0:
		get_tree().change_scene("res://scenes/endgame.tscn")

func clear_scene():
	tip_shown = false
	for child in ouija.get_children():
		child.modulate.a = 1
	for child in target_spaces.get_children():
		child.queue_free()
