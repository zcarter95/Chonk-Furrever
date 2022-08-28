extends KinematicBody2D

class_name Player

const UP_DIRECTION = Vector2.UP

onready var animatedSprite = $AnimatedSprite

export var speed = 100.0
export var jump_strength = 500.00
export var gravity = 2000.0

var velocity = Vector2.ZERO

func _physics_process(delta):
	# Get Input
	var horizontal_direction = (Input.get_action_strength("right") - Input.get_action_strength("left"))
	
	# Update Horizontal Velocity
	velocity.x = horizontal_direction * speed
	# Apply Gravity
	velocity.y += gravity * delta
	
	#Jump Logic
	var is_falling = velocity.y > 0.0 and not is_on_floor()
	var is_jumping = Input.is_action_just_pressed("jump") and is_on_floor()
	var is_jump_cancelled = Input.is_action_just_released("jump") and velocity.y < 0.0
	var is_idling = is_on_floor() and is_zero_approx(velocity.x)
	var is_running = is_on_floor() and not is_zero_approx(velocity.x)
	
	if is_jumping: 
		velocity.y = -jump_strength
	elif is_jump_cancelled:
		velocity.y = 0.0
	
	# Apply Velocity
	velocity = move_and_slide(velocity, UP_DIRECTION)
	
	# Flip Sprite
	if velocity.x >= 0:
		animatedSprite.flip_h = false
	elif velocity.x <= 0:
		animatedSprite.flip_h = true
		
	

