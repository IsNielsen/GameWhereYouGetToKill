extends Control


func _on_play_pressed() -> void:
	print("LOAD GAME SCENE")
	# TODO change to actual scene
	get_tree().change_scene_to_file("res://scenes/World.tscn")
