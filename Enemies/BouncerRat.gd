extends StaticBody2D

onready var animatedSprite = $AnimatedSprite
onready var animationPlayer = $AnimationPlayer

func _on_Area2D_body_entered(body):
	if body is Player:
		if body.cat_state == 3:
			animatedSprite.animation = "Scared"


func _on_AnimatedSprite_animation_finished():
	animatedSprite.animation = "Runaway"
	animationPlayer.play("Runaway")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Runaway":
			queue_free()
