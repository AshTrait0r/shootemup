extends Node2D

@export var level1_scene = preload("res://Scenes/Levels/Level1.tscn")
@onready var start_screen = $CanvasLayer/StartScreen

func _ready() -> void:
	show_start_screen()


func show_start_screen():
	start_screen.show()

	
func _on_ChooseRussian_pressed() -> void:
	Global.current_language = "rus"
	get_tree().change_scene_to_packed(level1_scene)
	
func _on_ChooseEnglish_pressed() -> void:
	Global.current_language = "eng"
	get_tree().change_scene_to_packed(level1_scene)

