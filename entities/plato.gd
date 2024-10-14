extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -350.0
@onready var anim = $AnimatedSprite2D
@onready var ray = $RayCast2D
@onready var coyot = $Coyot


func _physics_process(delta):
	# Add the gravity.
	print(velocity.y)
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_forward") and (is_on_floor() || !coyot.is_stopped()):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#Animations
	if velocity.x > 0:
		anim.animation = "walk0"
		anim.speed_scale = 1.5
		anim.play()
	if velocity.x < 0:
		anim.animation = "walk1"
		anim.speed_scale = 1.5
		anim.play()
	if velocity.x == 0:
		anim.stop()
		
		
	#Coyot Time
	var was_on_floor = is_on_floor()
	
	if velocity.y > 250:
		velocity.y += 0.5
	move_and_slide()
	
	if was_on_floor && !is_on_floor():
		coyot.start()
