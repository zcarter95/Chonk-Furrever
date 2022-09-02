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

onready var animationPlayer = $AnimationPlayer

export var cat1_speed = 130.0
export var cat2_speed = 120.0
export var cat3_speed = 110.0
export var cat4_speed = 100.0
export var cat1_jump_strength = 600.0
export var cat2_jump_strength = 550.0
export var cat3_jump_strength = 475.0
export var cat4_jump_strength = 425.0
export var gravity = 2000.0

enum cat_states {CAT1, CAT2, CAT3, CAT4}

var velocity = Vector2.ZERO
export (cat_states) var cat_state
var speed = 100.0
var jump_strength = 500.00
var food_consumed = 0
var missable_food_consumed = 0
var horizontal_direction = 0

func _ready():
	cat1AnimatedSprite.visible = false
	cat2AnimatedSprite.visible = false
	cat3AnimatedSprite.visible = false
	cat4AnimatedSprite.visible = false
	cat1CollisionShape.disabled = true
	cat2CollisionShape.disabled = true
	cat3CollisionShape.disabled = true
	cat4CollisionShape.disabled = true
	
	handle_cat_state()

func _physics_process(delta):
	
	handle_cat_state()
	level_up()
	
	# Get Input
	horizontal_direction = (Input.get_action_strength("right") - Input.get_action_strength("left"))
	
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
		
	if is_jumping:
		match cat_state:
			cat_states.CAT1:
				cat1AnimatedSprite.animation = "Jump"
			cat_states.CAT2:
				cat2AnimatedSprite.animation = "Jump"
			cat_states.CAT3:
				cat3AnimatedSprite.animation = "Jump"
			cat_states.CAT4:
				cat4AnimatedSprite.animation = "Jump"
	elif is_running:
		match cat_state:
			cat_states.CAT1:
				cat1AnimatedSprite.animation = "Run"
			cat_states.CAT2:
				cat2AnimatedSprite.animation = "Run"
			cat_states.CAT3:
				cat3AnimatedSprite.animation = "Run"
			cat_states.CAT4:
				cat4AnimatedSprite.animation = "Run"
	elif is_falling:
		match cat_state:
			cat_states.CAT1:
				cat1AnimatedSprite.animation = "Falling"
			cat_states.CAT2:
				cat2AnimatedSprite.animation = "Falling"
			cat_states.CAT3:
				cat3AnimatedSprite.animation = "Falling"
			cat_states.CAT4:
				cat4AnimatedSprite.animation = "Falling"
	elif is_idling:
		match cat_state:
			cat_states.CAT1:
				cat1AnimatedSprite.animation = "Idle"
			cat_states.CAT2:
				cat2AnimatedSprite.animation = "Idle"
			cat_states.CAT3:
				cat3AnimatedSprite.animation = "Idle"
			cat_states.CAT4:
				cat4AnimatedSprite.animation = "Idle"
	
func player_hurt():
	food_consumed -= 1
	if food_consumed < 0:
		food_consumed = 0
		
func receive_knockback(damage_source_pos: Vector2):
	var knockback_direction = damage_source_pos.direction_to(self.global_position)
	var knockback_strength = 10
	var knockback = knockback_direction * knockback_strength
	
	global_position += knockback
	global_position.y += 10
		
		
func handle_cat_state():
	match cat_state:
		cat_states.CAT1: 
			cat1AnimatedSprite.playing = true
			cat1AnimatedSprite.visible = true
			cat1CollisionShape.disabled = false
			speed = cat1_speed
			jump_strength = cat1_jump_strength
			
			cat2AnimatedSprite.playing = false
			cat2AnimatedSprite.visible = false
			cat2CollisionShape.disabled = true
			cat2AnimatedSprite.playing=false
			cat3AnimatedSprite.visible = false
			cat3CollisionShape.disabled = true
			cat3AnimatedSprite.playing = false
			cat4AnimatedSprite.visible = false
			cat4CollisionShape.disabled = true
			cat4AnimatedSprite.playing = false
			
		cat_states.CAT2:
			cat2AnimatedSprite.playing = true
			cat2AnimatedSprite.visible = true
			cat2CollisionShape.disabled = false
			speed = cat2_speed
			jump_strength = cat2_jump_strength
			
			cat1AnimatedSprite.visible = false
			cat1CollisionShape.disabled = true
			cat1AnimatedSprite.playing = false
			cat3AnimatedSprite.visible = false
			cat3CollisionShape.disabled = true
			cat3AnimatedSprite.playing = false
			cat4AnimatedSprite.visible = false
			cat4CollisionShape.disabled = true
			cat4AnimatedSprite.playing = false
			
		cat_states.CAT3:
			cat3AnimatedSprite.playing = true
			cat3AnimatedSprite.visible = true
			cat3CollisionShape.disabled = false
			speed = cat3_speed
			jump_strength = cat3_jump_strength
			
			cat1AnimatedSprite.visible = false
			cat1CollisionShape.disabled = true
			cat1AnimatedSprite.playing = false
			cat2AnimatedSprite.visible = false
			cat2CollisionShape.disabled = true
			cat2AnimatedSprite.playing = false
			cat4AnimatedSprite.visible = false
			cat4CollisionShape.disabled = true
			cat4AnimatedSprite.playing = false
		cat_states.CAT4:
			cat4AnimatedSprite.playing = true
			cat4AnimatedSprite.visible = true
			cat4CollisionShape.disabled = false
			speed = cat4_speed
			jump_strength = cat4_jump_strength
			
			cat1AnimatedSprite.playing = false
			cat1AnimatedSprite.visible = false
			cat1CollisionShape.disabled = true
			cat2AnimatedSprite.playing = false
			cat2AnimatedSprite.visible = false
			cat2CollisionShape.disabled = true
			cat3AnimatedSprite.playing = false
			cat3AnimatedSprite.visible = false
			cat3CollisionShape.disabled = true
			
func level_up():
	if food_consumed == 0:
		cat_state = cat_states.CAT1
	if food_consumed == 1:
		cat_state = cat_states.CAT2
	if food_consumed == 2:
		cat_state = cat_states.CAT3
	if food_consumed == 3:
		cat_state = cat_states.CAT4
		
		
		
			
			
		

		
	

