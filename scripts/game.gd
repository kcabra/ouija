extends Node2D

var level = [1, 1, 2]
var level2 = [1, 2, 2, 3]

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
	pass
#	var mob_sprite = Sprite.new()
#	mob_sprite.texture = load("res://monsters/frog.png")