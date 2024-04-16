extends Enemy

var SkeletonScene
var enemy_container
var difficulty

func _ready():
	starting_health = randi_range(7,11)
	starting_speed = 4
	super._ready()
	
func _physics_process(_delta: float = 0) -> void:
	super._physics_process()

func spawn_skeletons() -> void:
	var enemy_instance: Enemy = SkeletonScene.instantiate()
	#var spawns = spawn_container.get_children()
	#var index = randi() % spawns.size()
	var pos = global_position
	pos.x = randi_range(position.x - 20, position.x + 20)
	pos.y = position.y + 40
	enemy_instance.global_position = pos
	enemy_container.add_child(enemy_instance)
	enemy_instance.set_difficulty(difficulty)

func get_params(NewSkeletonScene, new_enemy_container, new_difficulty):
	SkeletonScene = NewSkeletonScene
	enemy_container = new_enemy_container
	difficulty = new_difficulty

func _on_summon_timer_timeout():
	spawn_skeletons()
