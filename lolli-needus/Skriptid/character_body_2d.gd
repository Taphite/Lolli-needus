extends CharacterBody2D


const SPEED = 80.0
const JUMP_VELOCITY = -200.0
var jump_count = 0
var DASH_SPEED = 3
var is_dashing = false
var stamina = 100

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count == 1:
		velocity.y = JUMP_VELOCITY
		jump_count = 2
		stamina -= 10
		$DJparticles.emitting = true
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_count = 1
		
	if !Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump_count = 0
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("dash") and stamina >= 20:
		if !is_dashing and direction:
			start_dash()
			stamina -= 20
			
			
	if stamina < 100:
		stamina += 0.2
	elif stamina == 0:
		$Timer.start()
		
	if Sv.player_health <= 0:
		Sv.player_health = 100
		print('you died')
		get_tree().reload_current_scene()

		
	
	
	$Camera2D/stamina.text = str(round(stamina))
	$Camera2D/health.text = str(round(Sv.player_health))
	
	
	if Input.is_action_just_pressed("attack") and stamina >= 10:
		attack()
		stamina -= 10
	
	if direction:
		if is_dashing:
			velocity.x = direction * SPEED * DASH_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	
	


	if velocity.x > 0:
		#$Sprite2D.flip_h = false
		$dashparticles.gravity.x = -1000
		$attack_hitbox.scale = Vector2(1, 1)
		
		
	if velocity.x < 0:
		#$Sprite2D.flip_h = true
		$dashparticles.gravity.x = 1000
		$attack_hitbox.scale = Vector2(-1, 1)
		
		
		
		
		
	
	
	
	
	move_and_slide()
	
func start_dash():
	if !$dashtimer.is_connected("timeout", stop_dash):
		$dashtimer.connect("timeout", stop_dash)
	is_dashing = true
	$dashtimer.start()
	$dashparticles.emitting = true
		
func stop_dash():
	is_dashing = false 
	$dashparticles.emitting = false

func attack():
	if $attack_hitbox/attack_timer.time_left == 0:
		$attack_hitbox/attack_timer.start()
		for body in $attack_hitbox.get_overlapping_bodies():
			print("kokkupõrge ", body )
		
		
