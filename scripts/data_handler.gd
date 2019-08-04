extends Node

var monster_db = Array()

func _ready():
	var enemy_data = File.new()
	enemy_data.open("res://monster_db", File.READ)
	var lines = enemy_data.get_as_text().strip_edges().split("\n")
	for line in lines:
		line = line.split(",")
		var monster = {
			"tier": int(line[0]),
			"sprite": line[1],
			"sfx": line[2],
			"solve": line[3],
			"tip": line[4] }
		monster_db.append(monster)