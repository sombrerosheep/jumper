extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(sz: Vector2):
	$Bounds/BoundsShape.position = Vector2(0,0)
	#$Bounds/BoundsShape.shape.size = sz
	$Bounds/BoundsShape.shape.set("size", sz)
	
	#$Bounds/BoundsShape/ColorRect.size = sz
	#$Bounds/BoundsShape/ColorRect.set("size", sz)
	$Bounds/BoundsShape/ColorRect.rect_size = sz
	
	#$Bounds/BoundsShape/ColorRect.position = Vector2(-(sz.x / 2), -(sz.y / 2))
	#$Bounds/BoundsShape/ColorRect.set("position", Vector2(-(sz.x / 2), -(sz.y / 2)))
	$Bounds/BoundsShape/ColorRect.rect_position = Vector2(-(sz.x / 2), -(sz.y / 2))
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
