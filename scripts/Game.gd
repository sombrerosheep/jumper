extends Node2D

signal game_over
signal game_end

enum GameState {GETTING_STARTED, PLAYING, GAME_OVER, END}

export var ready_countdown: float = 3.0
export var ready_message: String = "Go!"

var state = GameState.GAME_OVER

var init_play_time: float = 25.0
var portal_bonus: float = 0.0
var porta_bonus_multiplier = 1.5

var jumps: int = 0
var play_time: float = 0.0
var world_sz: Vector2 = Vector2(4000, 2500)

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


func new_game():
	show()
	state = GameState.GETTING_STARTED

	$HUD.show()
	jumps = 0
	play_time = init_play_time

	$Ship.start(Vector2(0,0), world_sz)

	$MainCamera.setup($Ship.position, world_sz)
	$MainCamera.set_target($Ship)

	setup_level()
	$StartCountdown.init(ready_countdown, ready_message)

func setup_level():
	var portal_buffer = 32
	$PortalMarker.position.x = rand_range(portal_buffer, world_sz.x - (portal_buffer * 2)) - world_sz.x / 2
	$PortalMarker.position.y = rand_range(portal_buffer, world_sz.y - (portal_buffer * 2)) - world_sz.y / 2
	
	var player_portal_diff = $PortalMarker.position - $Ship.position
	var diff_mag = player_portal_diff.length()
	portal_bonus = diff_mag / 1000 * porta_bonus_multiplier

	$Portal.start($PortalMarker.position)

	$HUD.update_playtime(play_time)

func is_out_of_bounds(rec: Rect2) -> bool:
	var half_bx = world_sz.x / 2
	var half_by = world_sz.y / 2

	if rec.position.x - rec.size.x / 2 < -half_bx:
		return true
	if rec.position.x + rec.size.x / 2 > half_bx:
		return true
	if rec.position.y - rec.size.y / 2 < -half_by:
		return true
	if rec.position.y + rec.size.y / 2 > half_by:
		return true
	
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		GameState.GETTING_STARTED:
			# countdown is processing
			pass
		GameState.PLAYING:
			play_time = max(0, play_time - delta)
			$HUD.update_playtime(play_time)

			if is_out_of_bounds($Ship.get_rect()):
				state = GameState.GAME_OVER
			
			if play_time <= 0.0:
				state = GameState.GAME_OVER
				play_time = 0.0

			if state == GameState.GAME_OVER:
				emit_signal("game_over")
		GameState.GAME_OVER:
			yield(get_tree().create_timer(3), "timeout")
			state = GameState.END
		GameState.END:
			emit_signal("game_end")
		_:
			pass

func _on_game_over():
	$Ship.shutdown()
	$FX/Die.play()

func _on_ship_jump():
	jumps += 1
	$FX/Jump.play()
	play_time += portal_bonus
	$HUD.set_jumps(jumps)
	setup_level()
	$AnimationPlayer.play("NextLevel")

func _on_countdown_complete():
	state = GameState.PLAYING
	$Ship.activate()