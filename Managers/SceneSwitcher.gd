extends Node

var next_level = null

onready var current_level = $Overworld
onready var animationPlayer = $AnimationPlayer

func _ready():
	current_level.connect("level_changed", self, "handle_level_changed")
	
func handle_level_changed(current_level_name: String):
	var next_level_name: String
	
	match current_level_name:
		"Overworld": 
			next_level_name = "Kitchen"
		"Kitchen":
			next_level_name = "Overworld"
		_:
			return
			
	next_level = load("res://World/Levels/" + next_level_name + "Level.tscn").instance()
	current_level.visible = false
	add_child(next_level)
	animationPlayer.play("FadeIn")
	next_level.connect("level_changed", self, "handle_level_changed")
	
func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"FadeIn":
			current_level.cleanup()
			current_level = next_level
			next_level = null
			current_level.visible = true
			animationPlayer.play("FadeOut")
		"FadeOut:":
			pass
