extends Node

var held_object = null
var lastMousePos = Vector2(0.0,0.0)

func _ready():
	for node in get_tree().get_nodes_in_group("pickable"):
		node.connect("clicked", self, "_on_pickable_clicked")

func _on_pickable_clicked(object):
	if !held_object:
		held_object = object
		held_object.pickup()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if held_object and !event.pressed: #Object is released
				held_object.drop(Input.get_last_mouse_speed())
				held_object = null
		if event.button_index == BUTTON_WHEEL_UP: #Object is held and scrolling up
			held_object.rotate_object(1)
		if event.button_index == BUTTON_WHEEL_DOWN: #Object is held and scrolling down
			held_object.rotate_object(-1)

			
