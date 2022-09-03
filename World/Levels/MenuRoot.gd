extends Control

var menu_transition_time = 0.5

var menu_origin_position := Vector2.ZERO
var menu_origin_size := Vector2.ZERO

var current_menu
var menu_stack := []

onready var mainMenu = $MainMenu
onready var controls = $Controls
onready var tween = $Tween
onready var animationPlayer = $AnimationPlayer

func _ready():
	menu_origin_position = Vector2(0, 0)
	menu_origin_size = get_viewport_rect().size
	current_menu = mainMenu
	animationPlayer.play("FadeIn")
	SoundManager.play_bgm("BGM")
	
func move_to_next_menu(next_menu_id: String):
	var next_menu = get_menu_from_menu_id(next_menu_id)
	tween.interpolate_property(current_menu, "rect_global_position", current_menu.rect_global_position,Vector2(-menu_origin_size.x, 0), menu_transition_time)
	tween.interpolate_property(next_menu, "rect_global_position", next_menu.rect_global_position,menu_origin_position, menu_transition_time)
	tween.start()
	menu_stack.append(current_menu)
	current_menu = next_menu

func move_to_previous_menu():
	var previous_menu = menu_stack.pop_back()
	if previous_menu != null:
		tween.interpolate_property(previous_menu, "rect_global_position", previous_menu.rect_global_position,menu_origin_position, menu_transition_time)
		tween.interpolate_property(current_menu, "rect_global_position", current_menu.rect_global_position,Vector2(menu_origin_size.x, 0), menu_transition_time)
		tween.start()
		current_menu = previous_menu
	
func get_menu_from_menu_id(menu_id: String) -> Control:
	match menu_id:
		"MainMenu":
			return mainMenu
		"Controls":
			return controls
		_:
			return mainMenu


func _on_Controls_pressed():
	move_to_next_menu("Controls")


func _on_Back_pressed():
	move_to_previous_menu()


func _on_StartGame_pressed():
	SceneManager.change_scene("res://World/Levels/AlleyLevel.tscn")
	
func play_boom_sound():
	SoundManager.play_se("Boom")
	
func play_boom2_sound():
	SoundManager.play_se("Boom2")
