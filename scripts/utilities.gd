class_name Utilities

static func Vector2_clamp(vec: Vector2, vmin: Vector2, vmax: Vector2) -> Vector2:
	if vec.x < vmin.x:
		vec.x = vmin.x
	if vec.y < vmin.y:
		vec.y = vmin.y
	if vec.x > vmax.x:
		vec.x = vmax.x
	if vec.y > vmax.y:
		vec.y = vmax.y
	
	return vec

static func Vector2_clampf(vec: Vector2, fmin: float, fmax: float) -> Vector2:
	if vec.x < fmin:
		vec.x = fmin
	if vec.y < fmin:
		vec.y = fmin
	if vec.x > fmax:
		vec.x = fmax
	if vec.y > fmax:
		vec.y = fmax
	
	return vec
