extends CharacterBody2D


var SPEED : int

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var intangles = [-90,0,90,180]
@onready var inter = $"RayCast2D"
@onready var animat = $AnimatedSprite2D

func _ready():
	SPEED = 200
	
func interact():
	var detectedint = inter.get_collider()
	if detectedint != null:
		#var scre = detectedint.get_parent()
		if detectedint.collision_layer == 2 or 4 and detectedint.script != null:
			detectedint.inter()

func get_input():
	var inp_dir = Input.get_vector("move_left","move_right","move_forward","move_backward")
	velocity = inp_dir * SPEED
	if Input.is_action_just_pressed("Interact"):
		interact()
	
func _physics_process(delta):
	get_input()
	move_and_slide()
	
	var mouser = get_local_mouse_position()
	#PI = half of sprite angles
	var angler = snappedf(mouser.angle(),PI/2) / (PI/2)
	angler = wrapi(int(angler),0,4)
	
	animat.animation = "walk" + str(angler)
	inter.rotation_degrees = intangles[angler]
	
	if velocity.length() != 0:
		animat.play()
	else:
		animat.stop()
		animat.frame = 0
