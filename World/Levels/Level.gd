extends Node2D

onready var camera = $Camera2D
onready var bottomLeft = $BottomLeft
onready var topRight = $TopRight
onready var player = $Player
onready var food = $Food

onready var food_count = food.get_child_count()

var new_dialog = Dialogic.start("StuckTimeline")

func _physics_process(delta):
	camera.limit_bottom = bottomLeft.position.y
	camera.limit_left = bottomLeft.position.x
	camera.limit_top = topRight.position.y
	camera.limit_right = topRight.position.x
	
	if Input.is_action_just_pressed("restart"):
		SceneManager.reload_scene()
	
	food_count = food.get_child_count()

	if player.cat_state >= 2 && player.missable_food_consumed == 0:
		add_child(new_dialog)
