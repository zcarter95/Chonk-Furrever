extends Node2D

onready var camera = $Camera2D
onready var bottomLeft = $BottomLeft
onready var topRight = $TopRight

func _physics_process(delta):
	camera.limit_bottom = bottomLeft.position.y
	camera.limit_left = bottomLeft.position.x
	camera.limit_top = topRight.position.y
	camera.limit_right = topRight.position.x
