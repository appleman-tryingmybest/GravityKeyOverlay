extends RigidBody2D

var text : String

@onready var col = $CollisionShape2D
@onready var areaCol = $Area2D/CollisionShape2D

var particle = preload("res://particle.tscn")
var sound1 = preload("res://sounds/impact.ogg")
var sound2 = preload("res://sounds/impact2.ogg")

func _ready() -> void:
	$ColorRect/Label.text = text
	linear_velocity = Vector2(randf_range(-200, 200), randf_range(-200, 200))
	angular_velocity = randf_range(-25, 25)

func _on_timer_timeout() -> void:
	queue_free()

func _on_color_rect_resized() -> void:
	if $ColorRect.size != Vector2(30.0, 30.0):
		col.shape = col.shape.duplicate()
		col.shape.size = $ColorRect.size
		areaCol.shape = areaCol.shape.duplicate()
		areaCol.shape.size = $ColorRect.size

func _exit_tree() -> void:
	var spawn = particle.instantiate()
	get_parent().call_deferred("add_child", spawn)
	spawn.global_position = global_position

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != self:
		if randi_range(0, 1) == 0:
			play_sound(sound1)
		else:
			play_sound(sound2)

func play_sound (stream: AudioStream): # YOU CAN JUST COPY AND PASTE THIS
	var p = AudioStreamPlayer2D.new() # make new audioplayer
	p.stream = stream
	p.pitch_scale = 1 + randf_range(-0.4, 0.2)
	p.volume_db = -25
	add_child(p) # adds to the world
	p.play() # play first
	p.finished.connect(p.queue_free) # remove itself after finished playing
