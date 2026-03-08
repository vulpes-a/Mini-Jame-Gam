extends Node2D
@onready var player: CharacterBody2D = $"../player"

const SPEED = 50.0
var direction = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if player.stop_time:
		return
		
	position.y += direction * SPEED * delta



func _on_timer_timeout() -> void:
	
	if player.stop_time:
		return
		
	direction *= -1
