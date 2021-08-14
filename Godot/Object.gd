extends RigidBody2D


signal clicked

var held = false

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:

			emit_signal("clicked", self)

func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position()

func rotate_object(value):
	set_global_rotation(global_rotation + value * 0.1)
	pass

func pickup():
	if held:
		return
	mode = RigidBody2D.MODE_STATIC
	held = true

func drop(impulse=Vector2.ZERO):
	if held:
		mode = RigidBody2D.MODE_RIGID

		#apply_torque_impulse( apply_central_impulse(impulse * 1)

		apply_central_impulse (impulse*20)
		held = false
