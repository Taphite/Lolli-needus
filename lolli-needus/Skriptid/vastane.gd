extends Node2D

const SPEED = 60



var direction = 1
@onready var raycastright: RayCast2D = $raycastright
@onready var raycastleft: RayCast2D = $raycastleft


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $raycastright.is_colliding():
		direction = -1
		#for body in $raycastright.get_collider():
		if $raycastright.get_collider().name == "ants" and $enemyatktimer.time_left == 0:
			Sv.player_health -= 20
			$enemyatktimer.start()
			
	if $raycastleft.is_colliding():
		direction = 1
		#for body in $raycastleft.get_collider():
		if $raycastleft.get_collider().name == "ants" and $enemyatktimer.time_left == 0:
			Sv.player_health -= 20
			$enemyatktimer.start()
	
	position.x += direction * SPEED * delta
