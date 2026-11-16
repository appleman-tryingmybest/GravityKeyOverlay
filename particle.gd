extends CPUParticles2D

@onready var poof = preload("res://sounds/poof.ogg")

func _ready() -> void:
	emitting = true
	play_sound(poof)

func _on_finished() -> void:
	queue_free()

func play_sound (stream: AudioStream): # YOU CAN JUST COPY AND PASTE THIS
	var p = AudioStreamPlayer2D.new() # make new audioplayer
	p.stream = stream
	p.pitch_scale = 1 + randf_range(-0.4, 0.4)
	p.volume_db = -4
	add_child(p) # adds to the world
	p.play() # play first
	p.finished.connect(p.queue_free) # remove itself after finished playing
