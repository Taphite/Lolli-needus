extends Area2D

@onready var timer = $Timer

func _on_body_entered(_ants):
	print('you died')
	Engine.time_scale = 0.5
	_ants.get_node("CollisionShape2D").queue_free()
	timer.start()
	
	

func _on_timer_timeout():
	Engine.time_scale = 1
	Sv.player_health = 100
	get_tree().reload_current_scene()
