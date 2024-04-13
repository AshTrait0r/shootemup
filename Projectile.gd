extends Area2D

class_name Projectile

var direction: Vector2
var speed: float = 5.0

func _ready() -> void:
	body_entered.connect(on_body_entered)

func _physics_process(delta: float) -> void:
	
	position += (direction - position)/speed
	look_at(direction.rotated(deg_to_rad(-15)))

func on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		queue_free()
