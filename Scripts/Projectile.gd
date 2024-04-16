extends Area2D

class_name Projectile

@onready var deletion_timer: Timer = $DeletionTimer
@onready var text: RichTextLabel = $Node2D/RichTextLabel2
var direction: Vector2
var speed: float = 15.0
var active_enemy: Enemy
@onready var letter: String

func _ready() -> void:
	rotate(deg_to_rad(-90))
	body_entered.connect(on_body_entered)
	deletion_timer.start()

func _physics_process(_delta: float) -> void:
	
	text.text = letter
	position += (direction - position)/speed
	look_at(direction)

func on_body_entered(body: Node2D) -> void:
	if body == active_enemy:
		body.get_damage()
		queue_free()

func _on_deletion_timer_timeout():
	queue_free()
