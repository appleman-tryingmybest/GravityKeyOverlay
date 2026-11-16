extends Node2D

@export var box = preload("res://letterbox.tscn")

var monitored_keys = [
	KEY_A, KEY_B, KEY_C, KEY_D, KEY_E, KEY_F, KEY_G, KEY_H, KEY_I, KEY_J, 
	KEY_K, KEY_L, KEY_M, KEY_N, KEY_O, KEY_P, KEY_Q, KEY_R, KEY_S, KEY_T, 
	KEY_U, KEY_V, KEY_W, KEY_X, KEY_Y, KEY_Z, 
	KEY_0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8, KEY_9,
	KEY_SPACE, KEY_ENTER, KEY_ESCAPE, KEY_BACKSPACE, KEY_INSERT, KEY_UP, KEY_RIGHT, KEY_DOWN, KEY_LEFT,
	KEY_SHIFT, KEY_CTRL, KEY_ALT
]


var key_display : String = ""

func _ready() -> void:
	if Engine.has_singleton("MousePassthrough"):
		Engine.get_singleton("MousePassthrough").set_passthrough(get_window().get_window_id(), true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for key in monitored_keys:
		if GlobalInput.is_global_key_just_pressed(key):
			key_display = OS.get_keycode_string(key)
			_create_box(key_display)
			break

func _create_box(key: String):
	var physbox = box.instantiate()
	get_parent().call_deferred("add_child", physbox)
	physbox.text = key
	physbox.global_position = Vector2(randf_range(576.0, -576.0), -384)
