extends Area2D

class_name Projectile

@onready var deletion_timer: Timer = $DeletionTimer
@onready var arrow_sprite: Sprite2D = $Arrow1
var direction: Vector2
var speed: float = 5.0
var active_enemy: Enemy

func _ready() -> void:
	#rotate(deg_to_rad(-90))
	look_at(Vector2(270,75))
	body_entered.connect(on_body_entered)
	deletion_timer.start()

func _physics_process(_delta: float) -> void:
	
	look_at(direction)
	position += (direction - position)/speed

func on_body_entered(body: Node2D) -> void:
	if body == active_enemy:
		body.get_damage()
		queue_free()

func _on_deletion_timer_timeout():
	queue_free()
