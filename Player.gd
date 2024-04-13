extends CharacterBody2D

class_name Player

@export var projectile: PackedScene

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()


func shoot() -> void:
	print("BANG!")
