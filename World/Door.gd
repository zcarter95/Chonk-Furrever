extends Area2D

export(String) var scene_to_load


func _on_Door_body_entered(body):
	if body is Player:
		get_tree().change_scene(scene_to_load)
