extends Node2D

const SPEED = 60

var enemy_health = 100

var direction = 1
var raycastright: RayCast2D
var raycastleft: RayCast2D


func _ready():
	# Initialize and add the RayCast2D to the scen
	raycastright = RayCast2D.new()
	raycastleft = RayCast2D.new()
	add_child(raycastright)
	add_child(raycastleft)
	
	# Configure the RayCast2D
	raycastright.enabled = true
	raycastright.target_position = Vector2(5, 0)  # Casts to the right
	raycastleft.enabled = true
	raycastleft.target_position = Vector2(-5, 0)  # Casts to the left
	
	
	
func take_damage(damage_amount):
	enemy_health -= damage_amount
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if raycastright.is_colliding():
		direction = -1
		#for body in $raycastright.get_collider():
		if raycastright.get_collider().name == "ants" and $enemyatktimer.time_left == 0:
			Sv.player_health -= 20
			print(raycastright.get_collider())
			$enemyatktimer.start()
			
	if raycastleft.is_colliding():
		direction = 1
		#for body in $raycastleft.get_collider():
		if raycastleft.get_collider().name == "ants" and $enemyatktimer.time_left == 0:
			Sv.player_health -= 20
			print(raycastleft.get_collider())
			$enemyatktimer.start()
	
	position.x += direction * SPEED * delta
	
	$Label.text = str(round(enemy_health))
	
	if enemy_health == 0:
		queue_free()
		
