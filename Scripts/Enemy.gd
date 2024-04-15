extends CharacterBody2D

class_name Enemy

@export_group("Color")
@export var blue = Color("#4682b4")
@export var green = Color("#639765")
@export var red = Color("#a65455")

@export_range(0,1000,0.1) var speed: float
@export var health: int

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var prompt: RichTextLabel = $RichTextLabel
@onready var prompt_text = prompt.text

var player_position
var target_position
@onready var player = get_parent().get_parent().get_node("Player")
@onready var stunned_timer: Timer = $StunnedTimer
@onready var death_timer: Timer = $DeathTimer
var is_stunned: bool = false
var is_dead: bool = false


func _ready() -> void:
	if global_position.x < 270:
		sprite.set_flip_h(true)
	prompt_text = PromptList.get_prompt()
	health = prompt_text.length()
	prompt.parse_bbcode(set_center_tags(prompt_text))
	GlobalSignals.connect("difficulty_increased", Callable(self, "handle_difficulty_increased"))


func _physics_process(_delta: float) -> void:
	
	if global_position.x < 270:
		sprite.set_flip_h(true)
	else:
		sprite.set_flip_h(false)
		
	if is_stunned or is_dead:
		velocity = Vector2.ZERO
		return
	
	player_position = player.position
	target_position = (player_position - position).normalized()
	#position += (player.position - position)/speed
	velocity = (player.position - position)/200 * speed
	move_and_slide()

func get_damage() -> void:
	is_stunned = true
	stunned_timer.start()
	health -= 1
	if health == 0:
		is_dead = true
		sprite.animation = "death" 
		death_timer.start()
		#queue_free()

func _on_stunned_timer_timeout():
	is_stunned = false

func _on_death_timer_timeout():
	queue_free()

func set_difficulty(difficulty: int):
	handle_difficulty_increased(difficulty)


func handle_difficulty_increased(new_difficulty: int):
	#var new_speed = speed + (0.125 * new_difficulty)
	speed = 20 + (1.25 * new_difficulty)


func get_prompt() -> String:
	return prompt_text


func set_next_character(next_character_index: int):
	#var blue_text = get_bbcode_color_tag(blue) + prompt_text.substr(0, next_character_index) + get_bbcode_end_color_tag()
	#var green_text = get_bbcode_color_tag(green) + prompt_text.substr(next_character_index, 1) + get_bbcode_end_color_tag()
	#var red_text = ""
	#
	#if next_character_index != prompt_text.length():
		#red_text = get_bbcode_color_tag(red) + prompt_text.substr(next_character_index + 1, prompt_text.length() - next_character_index + 1) + get_bbcode_end_color_tag()
#
	#prompt.parse_bbcode(set_center_tags(blue_text + green_text + red_text))

	var remaining_text = ""
	remaining_text = prompt_text.substr(next_character_index, prompt_text.length() - next_character_index)
	prompt.parse_bbcode(set_center_tags(remaining_text))

func set_center_tags(string_to_center: String):
	return "[center]" + string_to_center + "[/center]"


func get_bbcode_color_tag(color: Color) -> String:
	return "[color=#" + color.to_html(false) + "]"


func get_bbcode_end_color_tag() -> String:
	return "[/color]"

