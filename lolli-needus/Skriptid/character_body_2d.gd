extends CharacterBody2D


const SPEED = 80.0
const JUMP_VELOCITY = -200.0
const FRICTION = 75
var jump_count = 0
var DASH_SPEED = 3
var is_dashing = false
var stamina = 100
var walljump_count = 0


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	var old_velocity = velocity
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if is_on_wall() and !is_on_floor():
		velocity -= old_velocity * FRICTION * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count == 1 and !is_on_wall():
		velocity.y = JUMP_VELOCITY
		jump_count = 2
		stamina -= 10
		$DJparticles.emitting = true
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_count = 1
		
	if !Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump_count = 0
		walljump_count = 0
		
	if Input.is_action_just_pressed("ui_accept") and is_on_wall() and walljump_count < 3 and jump_count == 1 and !is_on_floor():
		if $attack_hitbox.scale == Vector2(1, 1):
			velocity.y = -200
			velocity.x = -250
			walljump_count += 1
			$walljumpparticles.emitting = true
		elif $attack_hitbox.scale == Vector2(-1, 1):
			velocity.y = -200
			velocity.x = 250
			walljump_count += 1
			$walljumpparticles.emitting = true
	
	
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	
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

		
	
	
	$stamina.text = str(round(stamina))
	$health.text = str(round(Sv.player_health))
	$Money.text = str(Sv.money) + "$"
	
	if Input.is_action_just_pressed("attack") and stamina >= 10:
		attack()
		stamina -= 10
		$attack_hitbox/Attackanimation.play()
		$attack_hitbox/SwordSFX.play()
		
	
	if direction:
		if is_dashing:
			velocity.x = direction * SPEED * DASH_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	
	


	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
		$dashparticles.gravity.x = -1000
		$attack_hitbox.scale = Vector2(1, 1)
		$walljumpparticles.gravity.x = -1000
		
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		$dashparticles.gravity.x = 1000
		$attack_hitbox.scale = Vector2(-1, 1)
		$walljumpparticles.gravity.x = 1000
		
		
		
		
		
	
	
	
	
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
			print(body.name)
			if body.name == "enemy":
				body.take_damage(50)
				print("Body detected:", body)
				print("Type:", body.get_class())
				print("Script attached:", body.get_script())

		
