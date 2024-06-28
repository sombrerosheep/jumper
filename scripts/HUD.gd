extends CanvasLayer

func _ready():
	hide()

# func _process(delta):
# 	pass
	
func set_jumps(jumps):
	$Jumps/JumpsCount.text = "%d" % jumps
	
func update_playtime(elapsed):
	$PlayTime.text = "%.2f" % elapsed
