extends Enemy

func _ready():
	starting_health = randi_range(3,6)
	super._ready()
