extends StaticBody2D

onready var animatedSprite = $AnimatedSprite
onready var animationPlayer = $AnimationPlayer
onready var timer = $Timer

var new_dialog = Dialogic.start("Bouncer")

func _on_Area2D_body_entered(body):
	if body is Player:
		if body.cat_state == 3:
			animatedSprite.animation = "Scared"
			timer.start()
		else:
			get_parent().add_child(new_dialog)

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Runaway":
			queue_free()


func _on_Timer_timeout():
	animatedSprite.animation = "Runaway"
	animationPlayer.play("Runaway")
