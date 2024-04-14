extends CharacterBody2D

class_name Player

@export var projectile: PackedScene
@onready var spawn_point: Marker2D = $SpawnPoint
var direction: Vector2

func _ready() -> void:
	rotate(deg_to_rad(-90))

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot(active_enemy = null) -> void:

	look_at(direction)
	var inst: Projectile = projectile.instantiate()
	owner.add_child(inst)
	inst.direction = active_enemy.global_position
	inst.transform = spawn_point.global_transform
