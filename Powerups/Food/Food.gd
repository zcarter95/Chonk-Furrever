extends Area2D

export (bool) var missable = false

func _on_Food_body_entered(body):
	if body is Player:
		body.food_consumed += 1
		if missable:
			body.missable_food_consumed += 1
		queue_free()
