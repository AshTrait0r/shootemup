extends Area2D

class_name Projectile

var direction: Vector2
var speed: float = 5.0

func _physics_process(delta: float) -> void:
	
	position += (direction - position)/speed
	look_at(direction)
