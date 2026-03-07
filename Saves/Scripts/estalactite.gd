extends TileMapLayer
@onready var player: CharacterBody2D = $"../player"

const SPEED = 500.0
const direction = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if player.stop_time:
		return
		
	position.y += direction * SPEED * delta
