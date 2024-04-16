extends Enemy

var is_summoned: bool

func _ready():
	starting_health = randi_range(3,6)
	super._ready()

func _physics_process(_delta: float = 0) -> void:
	if is_summoned:
		velocity = Vector2.ZERO
		sprite.play_backwards("death")
		return
	super._physics_process()

func _on_summoned_timer_timeout():
	is_summoned = false
	sprite.play("default")

func get_params(param_is_summoned):
	is_summoned = param_is_summoned
