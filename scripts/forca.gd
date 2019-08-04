extends Node2D

onready var ouija = $keyboard # node whose childs are the clickable chars
onready var target_spaces = $blank # node whose childs are the blanks and discovered chars
var target: String

var tip: String
var chances
var dica
func _ready():
	chances = 5
	dica = false
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
		print("errrooooouuuu")
		chances -= 1
	check_dica()
	check_loss()
	check_victory()

func check_victory():
	var won = true
	for child in target_spaces.get_children():
		if not child.revealed:
			won = false
			break
	if won:
		get_parent().get_next_monster()

func clear_scene():
	for child in ouija.get_children():
		child.modulate.a = 1
	for child in target_spaces.get_children():
		child.queue_free()
		
func check_loss():
	var missed = true
	if chances == 0:
		print("iou luse")
		chances = 5
		
func check_dica():
	if chances <= 2:
		if dica == false:
			dica = true
			print("mostrando le dica")
			
			
