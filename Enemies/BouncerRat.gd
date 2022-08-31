extends StaticBody2D

func _on_Area2D_body_entered(body):
	if body is Player:
		if body.cat_state == 3:
			queue_free()
