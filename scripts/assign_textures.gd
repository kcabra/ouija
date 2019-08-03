tool
extends EditorScript

func _run():
	var scene = get_scene()
	var parent = scene.get_node("ref_ouija/keyboard")
	for child in parent.get_children():
		child.set_script(load("res://scripts/keyboard.gd"))
