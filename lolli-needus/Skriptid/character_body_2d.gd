extends CharacterBody2D


const SPEED = 80.0
const JUMP_VELOCITY = -200.0
var jump_count = 0
var DASH_SPEED = 4
var is_dashing = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count == 1:
		velocity.y = JUMP_VELOCITY
		jump_count = 2
		
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_count = 1
		
	if !Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump_count = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("dash"):
		if !is_dashing and direction:
			start_dash()
	
	if direction:
		if is_dashing:
			velocity.x = direction * SPEED * DASH_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)



	if velocity.x > 0:
		$Sprite2D.flip_h = false
		$dashparticles.gravity.x = -2000
	
	if velocity.x < 0:
		$Sprite2D.flip_h = true
		$dashparticles.gravity.x = 2000
	
	
	
	
	
	move_and_slide()
	
func start_dash():
	is_dashing = true
	$dashtimer.connect("timeout", stop_dash)
	$dashtimer.start()
	$dashparticles.emitting = true
		
func stop_dash():
	is_dashing = false 
	$dashparticles.emitting = false
