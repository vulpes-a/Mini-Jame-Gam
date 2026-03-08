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
	freezetheme.stream_paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not maintheme.stream_paused:
		freezetheme.stream_paused = true
	
func freeze_theme() -> void:
	if not freezetheme.stream_paused:
		return
	maintheme.stream_paused = true
	freezetheme.stream_paused = false
	freezetheme.seek(maintheme.get_playback_position()*(2.0))
	
func unfreeze_theme() -> void:
	if freezetheme.stream_paused:
		return
	maintheme.stream_paused = false
	freezetheme.stream_paused = true
	maintheme.seek(freezetheme.get_playback_position()*(1.0/2.0))
