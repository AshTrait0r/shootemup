extends Enemy

class_name Necromancer

@onready var summon_animation_timer: Timer = $SummonAnimationTimer
var SkeletonScene
var enemy_container
var difficulty
var is_summoning: bool = false

func _ready():
	starting_health = randi_range(7,12)
	starting_speed = 4
	super._ready()
	
func _physics_process(delta: float = 0) -> void:
	if is_summoning:
		velocity = Vector2.ZERO
		return
	super._physics_process()

func spawn_skeletons() -> void:
	is_summoning = true
	summon_animation_timer.start()
	sprite.play("cast")
	var enemy_instance: Enemy = SkeletonScene.instantiate()
	#var spawns = spawn_container.get_children()
	#var index = randi() % spawns.size()
	var pos = global_position
	pos.x = randi_range(position.x - 20, position.x + 20)
	pos.y = position.y + 40
	enemy_instance.global_position = pos
	enemy_container.add_child(enemy_instance)
	enemy_instance.set_difficulty(difficulty)
	enemy_instance.get_params(true)

func get_params(NewSkeletonScene, new_enemy_container, new_difficulty):
	SkeletonScene = NewSkeletonScene
	enemy_container = new_enemy_container
	difficulty = new_difficulty

func _on_summon_timer_timeout():
	if is_dead:
		return
	spawn_skeletons()


func _on_summon_animation_timer_timeout():
	is_summoning = false
	sprite.play("default")
