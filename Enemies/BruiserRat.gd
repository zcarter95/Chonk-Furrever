extends KinematicBody2D

var velocity = Vector2.ZERO
var up_direction = Vector2.UP
var walking = false
export (Vector2) var direction = Vector2.RIGHT 
export var speed = 25

onready var rayCast = $RayCast2D
onready var animatedSprite = $AnimatedSprite
onready var timer = $Timer
onready var reverseDirectionTimer = $ReverseDirectionTimer
onready var animationPlayer = $AnimationPlayer
onready var sideChecker = $SideChecker/CollisionShape2D

func _ready():
	randomize()
	timer.wait_time = rand_range(2, 4)
	reverseDirectionTimer.wait_time = rand_range(3, 6)

func _physics_process(delta):
	var found_wall = is_on_wall()
	var found_edge = not rayCast.is_colliding()
	if found_wall || found_edge:
		direction *= -1
		scale.x *= -1
	if walking:
		animatedSprite.animation = "Run"
		velocity = direction * speed
	else:
		animatedSprite.animation = "Idle"
		velocity = direction * 0
	move_and_slide(velocity, up_direction)


func _on_Timer_timeout():
	walking = not walking


func _on_ReverseDirectionTimer_timeout():
	direction *= -1
	scale.x *= -1


func _on_TopChecker_body_entered(body):
	if body is Player:
		if body.cat_state >= 2:
			sideChecker.disabled = true
			velocity = direction * 0
			animationPlayer.play("Squash")
			SoundManager.play_se("Hurt")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Squash":
		queue_free()


func _on_SideChecker_body_entered(body):
	if body is Player:
		if body.cat_state < 2:
			body.player_hurt()
			body.receive_knockback(global_position)
		else:
			SoundManager.play_se("Hurt")
			animationPlayer.play("Squash")
