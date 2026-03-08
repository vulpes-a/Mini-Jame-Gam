extends Node

@onready var jump: AudioStreamPlayer = $Jump
@onready var land: AudioStreamPlayer = $Land
@onready var timefreeze_whistle: AudioStreamPlayer = $"Timefreeze&whistle"
@onready var timeunfreeze: AudioStreamPlayer = $Timeunfreeze
@onready var maintheme: AudioStreamPlayer = $Maintheme
@onready var walk: AudioStreamPlayer = $Walk
@onready var walk_timer: Timer = $Walk/Timer
@onready var freezetheme: AudioStreamPlayer = $Freezetheme


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func freeze_theme() -> void:
	if not freezetheme.stream_paused:
		return
	freezetheme.seek(maintheme.get_playback_position()*sqrt(4.0/3.0))
	maintheme.stream_paused = true
	freezetheme.stream_paused = false
	
func unfreeze_theme() -> void:
	if freezetheme.stream_paused:
		return
	maintheme.seek(freezetheme.get_playback_position()*sqrt(3.0/4.0))
	maintheme.stream_paused = false
	freezetheme.stream_paused = true
