extends KinematicBody2D

class_name Player

const UP_DIRECTION = Vector2.UP

onready var cat1AnimatedSprite = $Cat1AnimatedSprite
onready var cat2AnimatedSprite = $Cat2AnimatedSprite
onready var cat3AnimatedSprite = $Cat3AnimatedSprite
onready var cat4AnimatedSprite = $Cat4AnimatedSprite

onready var cat1CollisionShape = $Cat1CollisionShape2D
onready var cat2CollisionShape = $Cat2CollisionShape2D
onready var cat3CollisionShape = $Cat2CollisionShape2D
onready var cat4CollisionShape = $Cat1CollisionShape2D

export var cat1_speed = 130.0
export var cat2_speed = 120.0
export var cat3_speed = 110.0
export var cat4_speed = 100.0
export var cat1_jump_strength = 650.0
export var cat2_jump_strength = 600.0
export var cat3_jump_strength = 550.0
export var cat4_jump_strength = 500.0
export var gravity = 2000.0

enum {CAT1, CAT2, CAT3, CAT4}

var velocity = Vector2.ZERO
var cat_state = CAT1
var speed = 100.0
var jump_strength = 500.00
var food_consumed = 0

func _ready():
	cat1AnimatedSprite.visible = false
	cat2AnimatedSprite.visible = false
	cat3AnimatedSprite.visible = false
	cat4AnimatedSprite.visible = false
	cat1CollisionShape.disabled = true
	cat2CollisionShape.disabled = true
	cat3CollisionShape.disabled = true
	cat4CollisionShape.disabled = true
	
	cat_state()

func _physics_process(delta):
	
	cat_state()
	level_up()
	
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
	if velocity.x > 0:
		cat1AnimatedSprite.flip_h = false
		cat2AnimatedSprite.flip_h = false
		cat3AnimatedSprite.flip_h = false
		cat4AnimatedSprite.flip_h = false
	elif velocity.x < 0:
		cat1AnimatedSprite.flip_h = true
		cat2AnimatedSprite.flip_h = true
		cat3AnimatedSprite.flip_h = true
		cat4AnimatedSprite.flip_h = true
		
func cat_state():
	match cat_state:
		CAT1: 
			cat1AnimatedSprite.visible = true
			cat1CollisionShape.disabled = false
			speed = cat1_speed
			jump_strength = cat1_jump_strength
			
			cat2AnimatedSprite.visible = false
			cat2CollisionShape.disabled = true
			cat3AnimatedSprite.visible = false
			cat3CollisionShape.disabled = true
			cat4AnimatedSprite.visible = false
			cat4CollisionShape.disabled = true
			
		CAT2:
			cat2AnimatedSprite.visible = true
			cat2CollisionShape.disabled = false
			speed = cat2_speed
			jump_strength = cat2_jump_strength
			
			cat1AnimatedSprite.visible = false
			cat1CollisionShape.disabled = true
			cat3AnimatedSprite.visible = false
			cat3CollisionShape.disabled = true
			cat4AnimatedSprite.visible = false
			cat4CollisionShape.disabled = true
			
		CAT3:
			cat3AnimatedSprite.visible = true
			cat3CollisionShape.disabled = false
			speed = cat3_speed
			jump_strength = cat3_jump_strength
			
			cat1AnimatedSprite.visible = false
			cat1CollisionShape.disabled = true
			cat2AnimatedSprite.visible = false
			cat2CollisionShape.disabled = true
			cat4AnimatedSprite.visible = false
			cat4CollisionShape.disabled = true
		CAT4:
			cat4AnimatedSprite.visible = true
			cat4CollisionShape.disabled = false
			speed = cat4_speed
			jump_strength = cat4_jump_strength
			
			cat1AnimatedSprite.visible = false
			cat1CollisionShape.disabled = true
			cat2AnimatedSprite.visible = false
			cat2CollisionShape.disabled = true
			cat3AnimatedSprite.visible = false
			cat3CollisionShape.disabled = true
		
			
func level_up():
	if food_consumed == 0:
		cat_state = CAT1
	if food_consumed == 1:
		cat_state = CAT2
	if food_consumed == 2:
		cat_state = CAT3
	if food_consumed == 3:
		cat_state = CAT4
		
		
			
			
		

		
	

