extends Node2D

signal level_changed(level_name)

export(String) var level_name = "level"

func _on_Door_body_entered(body):
	if body is Player:
		emit_signal("level_changed", level_name)
