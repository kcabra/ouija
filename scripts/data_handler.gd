extends Node

var monster_db = {}

func _ready():
	var enemy_data = File.new()
	enemy_data.open("res://bixos.txt", File.READ)
	var lines = enemy_data.get_as_text().strip_edges().split("\n")
	for line in lines:
		line = line.split(",")
		var tier = int(line[1])
		var monster = {
			"id": int(line[0]),
			"name": line[2], # nome do bicho
			"solve": line[3] } # solução da forca
		if monster_db.has(tier):
			monster_db[tier].append(monster)
		else:
			monster_db[tier] = [monster]