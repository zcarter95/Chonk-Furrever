extends StaticBody2D

onready var animatedSprite = $AnimatedSprite
onready var animationPlayer = $AnimationPlayer
onready var timer = $Timer

var new_dialog = Dialogic.start("Bouncer")
var other_dialog = Dialogic.start("BouncerKitchen")

func _on_Area2D_body_entered(body):
	if body is Player:
		if body.cat_state == 3:
			animatedSprite.animation = "Scared"
			timer.start()
		elif get_tree().current_scene.name == "Overworld":
			get_parent().add_child(new_dialog)
		elif get_tree().current_scene.name == "Kitchen":
			get_parent().add_child(other_dialog)

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Runaway":
			queue_free()


func _on_Timer_timeout():
	animatedSprite.animation = "Runaway"
	animationPlayer.play("Runaway")
	
func _ready():
	print_debug(get_tree().current_scene)
