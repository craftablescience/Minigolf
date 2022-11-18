extends Node

func _on_UI_load_level_pressed():
	$Game.load_level()
	$UI/UI/Label.visible = false

func _on_UI_fire_pressed():
	$Game.fire()

func _on_game_goal_reached():
	$UI/UI/Label.visible = true
