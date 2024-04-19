extends Node2D

@export var SkeletonScene = preload("res://Scenes/Enemies/Skeleton.tscn")
@export var NecromancerScene = preload("res://Scenes/Enemies/Necromancer.tscn")
@export var NecrodogScene = preload("res://Scenes/Enemies/Necrodog.tscn")
@export var PlayerScene = preload("res://Scenes/Players/Player.tscn")
#@export var EnemyScene: PackedScene
#@export var PlayerScene: PackedScene

@onready var enemy_container = $EnemyContainer
@onready var spawn_container = $SpawnContainer
@onready var projectile_container = $ProjectileContainer
@onready var player_node = $Player
@onready var spawn_timer = $SpawnTimer
@onready var difficulty_timer = $DifficultyTimer
@onready var levelprompt: RichTextLabel = $RichTextLabel

@onready var difficulty_value = $CanvasLayer/HBoxContainer2/DifficultyValue
@onready var killed_value = $CanvasLayer/HBoxContainer/EnemiesKilledValue
@onready var game_over_screen = $CanvasLayer/GameOverScreen
@onready var game_over_killed_value = $CanvasLayer/GameOverScreen/CenterContainer/VBoxContainer/HBoxContainer2/GameOverKilledValue
@onready var accuracy_value = $CanvasLayer/GameOverScreen/CenterContainer/VBoxContainer/HBoxContainer/AccuracyValue

var used_letters: Array = Global.used_letters
var active_enemy: Enemy = null
var last_enemy: Enemy = null
var current_letter_index: int = -1
var remaining_text: String = ""

var current_necromants: Array = []
var who_to_spawn: int = 0
var lastposx: int = 40
var difficulty: int = 1
var enemies_killed: int = 0
var accuracy: float = 0
var correctlytyped: float = 0
var correctlytypedinminute: float = 0
var incorrectlytyped: float = 0
var firstletters: Array
var current_letter_enemy: Enemy = null
@onready var spawn_timer_time: int = spawn_timer.wait_time

func _ready() -> void:
	start_game()

func find_new_active_enemy(typed_character: String):
	var enemy_y: int = -100
	for enemy in enemy_container.get_children():
		var prompt = enemy.get_prompt()
		var next_character = prompt.substr(0, 1)
		firstletters.append(next_character)
		if next_character == typed_character or next_character == typed_character.to_upper() or next_character == typed_character.to_lower():
			if last_enemy == enemy or enemy.is_dead:
				continue
			if enemy.global_position.y > enemy_y:
				print("found new enemy that starts with %s and on %s" % [next_character.to_upper(), enemy.global_position.y])
				enemy_y = enemy.global_position.y
				active_enemy = enemy
				last_enemy = enemy
	if active_enemy != null:
		player_node.direction = active_enemy.global_position
		player_node.shoot(active_enemy)
		current_letter_index = 1
		remaining_text = active_enemy.set_next_character(current_letter_index)
		levelprompt.parse_bbcode(Prompt_list.set_center_tags(remaining_text))
		if remaining_text == "":
			active_enemy = null
		return
	if typed_character != "" and firstletters.find(typed_character) == -1 and not firstletters.is_empty():
		print("incorrectly typed %s instead of %s" % [typed_character,firstletters[0]])
		incorrectlytyped += 1
		print(incorrectlytyped)
			
			
	#for enemy in enemy_container.get_children():
		#var prompt = enemy.get_prompt()
		#var next_character = prompt.substr(0, 1)
		#firstletters.append(next_character)
		#if next_character in [typed_character,typed_character.to_upper(),typed_character.to_lower()]:
			#if enemy == last_enemy or enemy.is_dead:
				#continue
			#print("found new enemy that starts with %s" % next_character.to_upper())
			#active_enemy = enemy
			#last_enemy = enemy
			#player_node.direction = active_enemy.global_position
			#player_node.shoot(active_enemy)
			#current_letter_index = 1
			#active_enemy.set_next_character(current_letter_index)
			#return
	#if typed_character != "" and firstletters.find(typed_character) == -1:
		#print("incorrectly typed %s instead of %s" % [typed_character,firstletters[0]])
		#incorrectlytyped += 1
		#print(incorrectlytyped)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var typed_event = event as InputEventKey
		var key_typed
		key_typed = String.chr(typed_event.unicode)
			
		if active_enemy == null:
			find_new_active_enemy(key_typed)
		else:
			var prompt = active_enemy.get_prompt()
			var next_character = prompt.substr(current_letter_index, 1)
			if next_character == key_typed or next_character == key_typed.to_lower():
				print("successfully typed %s" % key_typed)
				player_node.direction = active_enemy.global_position
				player_node.shoot(active_enemy)
				correctlytyped += 1
				print(correctlytyped)
				current_letter_index += 1
				remaining_text = active_enemy.set_next_character(current_letter_index)
				levelprompt.parse_bbcode(Prompt_list.set_center_tags(remaining_text))
				if current_letter_index == prompt.length():
					print("done")
					current_letter_index = -1
					active_enemy = null
					enemies_killed += 1
					killed_value.text = str(enemies_killed)
					if enemy_container.get_child_count() < 3:
						print("spawned enemy")
						spawn_enemy()
			else:
				print("incorrectly typed %s instead of %s" % [key_typed, next_character])
				incorrectlytyped += 1
				print(incorrectlytyped)

func _on_SpawnTimer_timeout() -> void:
	spawn_enemy()

func spawn_enemy() -> void:
	if not current_necromants.is_empty() and current_necromants[0] == null:
		current_necromants.erase(current_necromants[0])
	who_to_spawn = randi() % 100
	if who_to_spawn < 40 - difficulty:
		spawn_necrodog()
	elif who_to_spawn > 40 - difficulty and who_to_spawn < 75 - difficulty:
		spawn_skeleton()
	elif who_to_spawn > 75 - difficulty and current_necromants.size() < 3:
		spawn_necromancer()
	else:
		spawn_skeleton()

func spawn_necrodog() -> void:
	var enemy_instance: Enemy = NecrodogScene.instantiate()
	#var spawns = spawn_container.get_children()
	#var index = randi() % spawns.size()
	var pos = global_position
	#if lastposx < 250:
		#pos.x = randi_range(lastposx + 20, 450)
	#else:
		#pos.x = randi_range(40, lastposx - 90)
	#lastposx = pos.x
	pos.x = 270
	pos.y = -20
	enemy_instance.global_position = pos
	enemy_container.add_child(enemy_instance)
	enemy_instance.set_difficulty(difficulty)

func spawn_skeleton() -> void:
	var enemy_instance: Enemy = SkeletonScene.instantiate()
	#var spawns = spawn_container.get_children()
	#var index = randi() % spawns.size()
	var pos = global_position
	if lastposx < 250:
		pos.x = randi_range(lastposx + 20, 450)
	else:
		pos.x = randi_range(40, lastposx - 90)
	lastposx = pos.x
	pos.y = -20
	enemy_instance.global_position = pos
	enemy_container.add_child(enemy_instance)
	enemy_instance.set_difficulty(difficulty)

func spawn_necromancer() -> void:
	var enemy_instance: Enemy = NecromancerScene.instantiate()
	#var spawns = spawn_container.get_children()
	#var index = randi() % spawns.size()
	var pos = global_position
	if lastposx < 250:
		pos.x = randi_range(lastposx + 20, 450)
	else:
		pos.x = randi_range(40, lastposx - 90)
	lastposx = pos.x
	pos.y = 0
	enemy_instance.global_position = pos
	enemy_container.add_child(enemy_instance)
	current_necromants.append(enemy_instance)
	enemy_instance.set_difficulty(difficulty)
	enemy_instance.get_params(SkeletonScene, enemy_container, difficulty)


func _on_DifficultyTimer_timeout() -> void:
	if difficulty >= 20:
		difficulty_timer.stop()
		difficulty = 20
		return

	difficulty += 1
	GlobalSignals.emit_signal("difficulty_increased", difficulty)
	print("Difficulty increased to %d" % difficulty)
	var new_wait_time = spawn_timer.wait_time - 0.2
	spawn_timer.wait_time = clamp(new_wait_time, 1, spawn_timer.wait_time)
	difficulty_value.text = str(difficulty)


func _on_LoseArea_body_entered(body: Node) -> void:
	if body.get_parent().name == "EnemyContainer":
		game_over()


func game_over():
	game_over_killed_value.text = str(enemies_killed)
	if (correctlytyped+incorrectlytyped) == 0:
		accuracy = 0;
	else:
		accuracy = correctlytyped * 100 / (correctlytyped+incorrectlytyped)
	accuracy_value.text = str(snapped(accuracy,0.001))
	game_over_screen.show()
	spawn_timer.wait_time = spawn_timer_time
	spawn_timer.stop()
	difficulty_timer.stop()
	active_enemy = null
	current_letter_index = -1
	for enemy in enemy_container.get_children():
		enemy.queue_free()
	for projectile in projectile_container.get_children():
		projectile.queue_free()


func start_game():
	game_over_screen.hide()
	difficulty = 0
	enemies_killed = 0
	correctlytyped = 0
	incorrectlytyped = 0
	difficulty_value.text = str(0)
	killed_value.text = str(0)
	randomize()
	spawn_timer.start()
	difficulty_timer.start()
	spawn_enemy()


func _on_RestartButton_pressed() -> void:
	start_game()
	
func _on_ChooseRussian_pressed() -> void:
	Global.current_language = "rus"
	start_game()
	
func _on_ChooseEnglish_pressed() -> void:
	Global.current_language = "eng"
	start_game()

func _on_speed_timer_timeout():
	correctlytypedinminute = correctlytyped - correctlytypedinminute
	print(correctlytypedinminute)
	#get_tree().set_deferred("paused",true)
