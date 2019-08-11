extends Sprite

onready var jogo = preload("res://game.tscn")
onready var cards = $"cards"

var credits = false
var scene

func _ready():
	$jogar.connect("pressed", self, "play")
	$creditos.connect("pressed", self, "creditos")

func play():
	cards.visible = true
	cards.intro()
	cards.connect("finished", self, "tutorial")

func tutorial():
	$ColorRect.visible = true
	cards.disconnect("finished", self, "tutorial")
	cards.connect("finished", self, "start")
	cards.tutorial()
	yield(cards, "finished")
	$ColorRect.visible = false

func start():
	get_tree().change_scene_to(jogo)

func creditos():
	scene = load("res://scenes/cards.tscn").instance()
	scene.get_node("creditos").visible = true
	credits = true
	add_child(scene)

func _process(_delta):
	if credits and Input.is_mouse_button_pressed(BUTTON_LEFT):
		scene.queue_free()
		credits = false
		get_tree().change_scene_to(jogo)