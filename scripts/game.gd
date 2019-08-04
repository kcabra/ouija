extends Node2D

onready var tween = $Tween
onready var forca_control = $forca

var level = [1, 2, 3]

var monster_array: Array
var loaded_monster = null

func _ready():
	for encounter in level:
		monster_array.append(get_random_monster_from_tier(encounter))
	load_monster(monster_array.pop_front())

func get_random_monster_from_tier(tier):
	randomize()
	var possible = Data.monster_db[tier]
	var chosen = randi() % possible.size()
	return possible[chosen]

func load_monster(monster):
	forca_control.target = monster["solve"]
	forca_control._ready()
	var mob_sprite: Sprite = Sprite.new()
	mob_sprite.texture = load("res://monsters/frog.png")
	mob_sprite.position = Vector2(300, 400)
	self.add_child(mob_sprite)
	loaded_monster = mob_sprite

func get_next_monster():
	if not monster_array.empty():
		loaded_monster.queue_free()
		forca_control.clear_scene()
		load_monster(monster_array.pop_front())
	else:
		print("you win!")