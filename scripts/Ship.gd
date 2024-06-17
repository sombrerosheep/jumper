extends KinematicBody2D

export var speed = 400
export var max_velocity = 200
export var rotation_speed = 3.5

var can_control: bool = true

var bounds: Vector2
var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.ZERO
	#hide()

func start(pos: Vector2,  b: Vector2):
	position = pos
	bounds = b
	can_control = true
	show()
	
func is_out_of_bounds() -> bool:
	var half_bx = bounds.x / 2
	var half_by = bounds.y / 2
	var sz: Vector2 = $Sprite.get_rect().size

	if position.x - sz.x / 2 < -half_bx:
		return true
	if position.x + sz.x / 2 > half_bx:
		return true
	if position.y - sz.y / 2 < -half_by:
		return true
	if position.y + sz.y / 2 > half_by:
		return true
	
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if can_control == true:
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
		
	else:
		rotation += rotation_speed * 2 * delta
		velocity = Vector2.ZERO
	
	var movement = speed * velocity * delta
	var collision = move_and_collide(movement)
	if collision:
		print("collided with: " + collision.get_collider().to_string())
	
	velocity.x -= velocity.x * .25 * delta
	velocity.y -= velocity.y * .25 * delta
	
	# if is_out_of_bounds() == true:
		# can_control = false
		# print("ship is out of bounds!")
