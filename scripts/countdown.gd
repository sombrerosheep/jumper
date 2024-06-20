extends CanvasLayer

signal countdown_complete

enum CountdownState {INIT, RUNNING, ELAPSED, DONE}

var count: float = 0.0
var state = CountdownState.DONE
var message_delay = 1.0
var message = ""

func _ready():
	hide()
	
func init(duration: float, complete_msg: String):
	count = duration
	message = complete_msg
	state = CountdownState.RUNNING
	show()

func _process(delta):
	match state:
		CountdownState.INIT:
			pass
		CountdownState.RUNNING:
			count -= delta

			if count < 0:
				count = 0
				state = CountdownState.ELAPSED

			$Text.text = "%.0f" % count
		CountdownState.ELAPSED:
			$Text.text = message
			count += delta

			if count > message_delay:
				state = CountdownState.DONE
				emit_signal("countdown_complete")
				hide()
		CountdownState.DONE:
			pass
