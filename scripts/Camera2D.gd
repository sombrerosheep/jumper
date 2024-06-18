extends Camera2D

export var lerp_weight: float = 2.0

var target: Node2D = null
var clamp_min: Vector2
var clamp_max: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if target != null:
		position = lerp(position, target.position, delta * lerp_weight)
	
	position = Utilities.Vector2_clamp(position, clamp_min, clamp_max)
	# position = position.clamp(clamp_min, clamp_max)

func set_bounds(b: Vector2):
	var viewport = get_viewport_rect().size

	clamp_min = Vector2(-(b.x / 2) + viewport.x / 2, -(b.y / 2) + viewport.y / 2)
	clamp_max = Vector2(b.x / 2 - viewport.x / 2, b.y / 2 - viewport.y / 2)

func set_target(t: Node2D):
	position = t.position
	target = t
