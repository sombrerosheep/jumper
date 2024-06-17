extends Node2D

var screen_size
var jumps = 0
var play_time = 0.0
var world_sz: Vector2 = Vector2(4000, 2500)
var half_world_sz: Vector2 = world_sz / 2

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$MainCamera.set_target($Ship)
	#$HUD.track_node($Ship)
	#$HUD.track_node($Jump)
	new_game()

func new_game():
	$World.init(world_sz)
	$MainCamera.set_bounds(world_sz)
	jumps = 0
	var player_start = Vector2.ZERO
	player_start = Vector2(0,0)
	$Ship.start(player_start, world_sz)
	
	setup_level()

func setup_level():
	var portal_buffer = 32
	$PortalMarker.position.x = rand_range(portal_buffer, world_sz.x - (portal_buffer * 2)) - world_sz.x / 2
	$PortalMarker.position.y = rand_range(portal_buffer, world_sz.y - (portal_buffer * 2)) - world_sz.y / 2

	$Portal.start($PortalMarker.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	play_time += delta
	$HUD.update_playtime(play_time)

func _on_ship_jump():
	jumps += 1
	$HUD.set_jumps(jumps)
	setup_level()
