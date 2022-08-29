extends Node

onready var current_level = $Overworld

func _ready():
	current_level.connect("level_changed", self, "handle_level_changed")
	
func handle_level_changed(current_level_name: String):
	var next_level
	var next_level_name: String
	
	match current_level_name:
		"Overworld": 
			next_level_name = "Kitchen"
		"Kitchen":
			next_level_name = "Overworld"
		_:
			return
			
	next_level = load("res://World/Levels/" + next_level_name + "Level.tscn").instance()
	add_child(next_level)
	next_level.connect("level_changed", self, "handle_level_changed")
	current_level.queue_free()
	current_level = next_level
	
