extends Node2D

const SPEED = 60

var direction = 1
@onready var raycastright: RayCast2D = $raycastright
@onready var raycastleft: RayCast2D = $raycastleft


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $raycastright.is_colliding():
		direction = -1
	if $raycastleft.is_colliding():
		direction = 1
	
	position.x += direction * SPEED * delta
