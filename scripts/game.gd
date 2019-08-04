extends Node2D

onready var tween = $Tween
onready var forca_control = $forca

var current_level = 0

var monster_array: Array = ["bat", "frog", "plant", "moth", "crow", "spider"]
var loaded_monster = null

func _ready():
	load_monster(monster_array.pop_front())

func load_monster(monster_name):
	var monster
	for mob in Data.monster_db:
		if mob["sprite"] == monster_name:
			monster = mob
			break
	forca_control.target = monster["solve"]
	forca_control.tip = monster["tip"]
	forca_control._ready()
	
	var mob_sprite: Sprite = Sprite.new()
	mob_sprite.texture = load("res://monsters/"+monster["sprite"]+".png")
	mob_sprite.position = Vector2(300, 400)
	
	var mob_sfx = AudioStreamPlayer.new()
	mob_sfx.stream = load("res://soundtrack/"+monster["sfx"]+".wav")
	mob_sfx.autoplay = true
	mob_sfx.volume_db = 5
	
	self.add_child(mob_sprite)
	mob_sprite.add_child(mob_sfx)
	loaded_monster = mob_sprite


func get_next_monster():
	if not monster_array.empty():
		get_node("CanvasLayer/ColorRect").visible = true
		loaded_monster.queue_free()
		yield(get_tree().create_timer(0.3), "timeout")
		get_node("CanvasLayer/ColorRect").visible = false
		yield(get_tree().create_timer(1.0), "timeout")
		get_node("CanvasLayer/ColorRect").visible = true
		yield(get_tree().create_timer(0.3), "timeout")
		get_node("CanvasLayer/ColorRect").visible = false
		yield(get_tree().create_timer(0.5), "timeout")
		get_node("CanvasLayer/ColorRect").visible = true
		yield(get_tree().create_timer(0.7), "timeout")
		load_monster(monster_array.pop_front())
		get_node("CanvasLayer/ColorRect").visible = false
	else:
		print("you win!")
