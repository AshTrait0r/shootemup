extends Node

func _process(delta):
	if Input.is_action_just_pressed("menu_pause"):
		if !get_tree().paused:
			pause()
		else:
			resume()

func pause():
	get_tree().set_deferred("paused",true)
	
func resume():
	get_tree().set_deferred("paused",false)
