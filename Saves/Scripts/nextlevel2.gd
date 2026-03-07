extends Area2D

const FILE_BEGIN = "res://Saves/levels/level_"

func _on_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Saves/levels/level_2.tscn")
