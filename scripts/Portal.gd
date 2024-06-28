extends Area2D

signal ship_jump

export var rotation_speed = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func start(pos):
	position = pos
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(body):
	if body.name == "Ship":
		# ship_jump.emit()
		emit_signal("ship_jump")
	else:
		print("portal collided with unhandled body: " + body.name)
