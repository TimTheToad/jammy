extends Node2D


var loaded = false
var alien_size


func calc_alien_size():
	var img = get_viewport().get_texture().get_data()
	img.lock()
	var tot = 0
	for x in img.get_width() / 4:
		for y in img.get_height() / 4:
			var p = img.get_pixel(x * 4, y * 4)
			# Color detection
			if p.r < 0.5 and p.g > 0.7 and p.b < 0.5:
				tot += 1
	return tot

func calc_alien_visibility():
	var current_size = calc_alien_size()
	return float(current_size) / alien_size

func _ready():
	yield(get_tree().create_timer(0.5), "timeout")
	alien_size = calc_alien_size()
	loaded = true

func _process(delta):
	for c in get_children():
		if c.name == "icon":
			c.position = get_global_mouse_position()
	
	if not loaded:
		return
	
	print(calc_alien_visibility())
