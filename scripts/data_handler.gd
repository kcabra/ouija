extends Node

var monster_db = Array()
var text_db = Dictionary()
var won = false

func _ready():
	load_enemy_data()
	load_text_data()

func load_enemy_data():
	var enemy_data = File.new()
	enemy_data.open("res://monster_db.txt", File.READ)
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

func load_text_data():
	var text_data = File.new()
	text_data.open("res://text_db.txt", File.READ)
	var raw_data = text_data.get_as_text()
	while not raw_data.empty():
		var name_start = raw_data.find("#") + 1
		var name_end = raw_data.find("\n", name_start)
		var section_name = raw_data.substr(name_start, name_end - name_start).to_lower()
		var section_start = name_end + 1
		var section_end
		if raw_data.find("#", name_end) != -1:
			section_end = raw_data.find("#", name_end) - 1
		else:
			section_end = raw_data.length() - 1
		var section_raw = raw_data.substr(section_start, section_end - section_start)
		var section_array = section_raw.strip_edges().split("\n\n")
		text_db[section_name] = Array(section_array)
		raw_data = raw_data.substr(section_end + 1, raw_data.length() - section_end)