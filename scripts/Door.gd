extends StaticBody2D

var state : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	state = true
	pass # Replace with function body.

func inter():
	$AudioStreamPlayer2D.play()
	if (state == true):
		self.set_collision_layer_value(1,false)
		$AnimatedSprite2D.frame = 1
		state = false
	else:
		self.set_collision_layer_value(1,true)
		$AnimatedSprite2D.frame = 0
		state = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
