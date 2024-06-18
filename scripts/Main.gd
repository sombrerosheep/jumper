extends Node2D

var game_scene = preload("res://scenes/Game.tscn").instance()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartGame_pressed():
	$UI.hide()
	get_node("GameRoot").add_child(game_scene)
	game_scene.start()
	game_scene.connect("game_over", self, "_on_Game_game_over")


func _on_Game_game_over():
	$UI.show()
	get_node("GameRoot").remove_child(game_scene)
