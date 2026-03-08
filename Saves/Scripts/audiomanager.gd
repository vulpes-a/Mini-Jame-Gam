extends Node

@onready var jump: AudioStreamPlayer = $Jump
@onready var land: AudioStreamPlayer = $Land
@onready var timefreeze_whistle: AudioStreamPlayer = $"Timefreeze&whistle"
@onready var timeunfreeze: AudioStreamPlayer = $Timeunfreeze
@onready var maintheme: AudioStreamPlayer = $Maintheme
@onready var walk: AudioStreamPlayer = $Walk
@onready var walk_timer: Timer = $Walk/Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
