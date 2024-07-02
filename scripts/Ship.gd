extends KinematicBody2D

var speed = 400
var max_velocity = 200
var rotation_speed = 3.5

var is_active: bool = false
var is_shutdown: bool = false
var thruster_held: float = 0
export var thrust_loop_begin: float = 1.780045351 # 78500 samples
var thrust_loop_end: float = 2.199546485		  # 97000 samples

var bounds: Vector2
var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.ZERO
	hide()

func start(pos: Vector2,  b: Vector2):
	velocity = Vector2.ZERO
	position = pos
	bounds = b
	is_active = false
	is_shutdown = false
	show()
	
func get_rect() -> Rect2:
	return Rect2(position, $Sprite.get_rect().size)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_active == true:
		if Input.is_action_pressed("left"):
			rotation -= rotation_speed * delta
		
		if Input.is_action_pressed("right"):
			rotation += rotation_speed * delta
		
		if Input.is_action_pressed("up"):
			velocity.x += cos(rotation) * delta
			velocity.y += sin(rotation) * delta
			
			if thruster_held == 0:
				$FX/Thrust.seek(0)
				$FX/Thrust.play()

			thruster_held += delta

			if thruster_held > thrust_loop_end:
				$FX/Thrust.seek(thrust_loop_begin)
				thruster_held = thrust_loop_begin
		else:
			thruster_held = 0
		
		if Input.is_action_pressed("down"):
			velocity.x -= velocity.x * .75 * delta
			velocity.y -= velocity.y * .75 * delta
		
		velocity = Utilities.Vector2_clampf(velocity, -max_velocity, max_velocity)
	
	if is_shutdown == true:
		rotation += rotation_speed * 2 * delta
		velocity = Vector2.ZERO
	
	var movement = speed * velocity * delta
	var collision = move_and_collide(movement)
	if collision:
		print("collided with: " + collision.get_collider().to_string())
	
	velocity.x -= velocity.x * .25 * delta
	velocity.y -= velocity.y * .25 * delta

func portal_jump():
	velocity *= 0.25
	thruster_held = 0
	is_active = false

func activate():
	is_active = true

func shutdown():
	$FX/Die.play()
	is_shutdown = false
