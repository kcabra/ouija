extends Node2D

var dark: Color = Color("0d0d0d")
var light:Color = Color("e7e7e7")

signal finished

onready var color_rect = $ColorRect
onready var tween = $Tween

var text_array: Array

func _ready():
	color_rect.modulate.a = 0
	if OS.is_debug_build():
#		tutorial()
		pass
	

func _load_text(txt_name):
	color_rect.visible = true
	text_array = Data.text_db[txt_name].duplicate()
	

func _next():
	if text_array.size():
		return text_array.pop_front()
	else:
		return "--FINISHED--"
	

func intro():
	_load_text("intro")
	var label: Label = color_rect.get_node("Label")
	color_rect.color = light
	label.add_color_override("font_color", dark)
	label.modulate.a = 0
	label.text = _next()
	tween.interpolate_property(color_rect, "modulate:a", 0, 1, 0.5, Tween.TRANS_CIRC, Tween.EASE_IN)
	tween.interpolate_property(label, "modulate:a", 0, 1, 0.5, Tween.TRANS_CIRC, Tween.EASE_IN, 0.5)
	tween.start()
	var running = true
	while true:
		while true:
			var input = yield(color_rect, "gui_input")
			if input.is_action_pressed("ui_accept"):
				break
		tween.interpolate_property(label, "modulate:a", label.modulate.a, 0, 0.3, Tween.TRANS_CIRC, Tween.EASE_OUT)
		tween.interpolate_property(label, "modulate:a", 0, 1, 0.5, Tween.TRANS_CIRC, Tween.EASE_IN, 0.3)
		tween.start()
		yield(tween, "tween_completed")
		var next = _next()
		if next != "--FINISHED--":
			label.text = next
		else:
			break
	tween.interpolate_property(color_rect, "modulate:a", 1, 0, 0.5, Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.start()
	running = false
	emit_signal("finished")
	

func tutorial():
	var label = color_rect.get_node("Label")
	_load_text("tutorial")
	color_rect.color = dark
	label.add_color_override("font_color", light)
	label.modulate.a = 0
	label.text = _next()
	tween.interpolate_property(color_rect, "modulate:a", 0, 1, 0.5, Tween.TRANS_CIRC, Tween.EASE_IN)
	tween.interpolate_property(label, "modulate:a", 0, 1, 0.5, Tween.TRANS_CIRC, Tween.EASE_IN, 0.5)
	tween.start()
	while true:
		while true:
			var input = yield(color_rect, "gui_input")
			if input.is_action_pressed("ui_accept"):
				break
		tween.interpolate_property(label, "modulate:a", label.modulate.a, 0, 0.3, Tween.TRANS_CIRC, Tween.EASE_OUT)
		tween.interpolate_property(label, "modulate:a", 0, 1, 0.5, Tween.TRANS_CIRC, Tween.EASE_IN, 0.3)
		tween.start()
		yield(tween, "tween_completed")
		var next = _next()
		if next != "--FINISHED--":
			label.text = next
		else:
			break
	emit_signal("finished")
	tween.interpolate_property(color_rect, "modulate:a", 1, 0, 0.5, Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.start()