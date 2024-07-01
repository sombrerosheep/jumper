extends Node2D

var game_scene = preload("res://scenes/Game.tscn").instance()


# func _ready():
# 	pass


# func _process(delta):
# 	pass


func _on_StartGame_pressed():
	$UI.hide()
	get_node("GameRoot").add_child(game_scene)
	game_scene.new_game()
	game_scene.connect("game_end", self, "_on_Game_game_over")

func _on_Game_game_over():
	$UI.show()
	get_node("GameRoot").remove_child(game_scene)
