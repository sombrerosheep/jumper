extends CanvasLayer

#var tracked_nodes : Array[Node2D] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	$TrackedNodes.text = ""
#	for i in tracked_nodes.size():
#		var n = tracked_nodes[i]
#		$TrackedNodes.text += "%.2f x %.2f\n" % [n.position.x, n.position.y]
	pass
	
func set_jumps(jumps):
	$Jumps/JumpsCount.text = "%d" % jumps
	
func update_playtime(elapsed):
	$PlayTime.text = "%.2f" % elapsed

#func track_node(node : Node2D):
#	tracked_nodes.push_back(node)
