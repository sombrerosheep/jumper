extends KinematicBody2D

var speed = 400
var max_velocity = 200
var rotation_speed = 3.5

var is_active: bool = false
var is_shutdown: bool = false

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
			#velocity += velocity.rotated(rotation)
		
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

func activate():
	is_active = true

func shutdown():
	is_shutdown = false
