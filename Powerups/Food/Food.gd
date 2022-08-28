extends Area2D

func _on_Food_body_entered(body):
	if body is Player:
		body.food_consumed += 1
		queue_free()
