extends Button
@onready var animated_sprite_2d: AnimatedSprite2D = $button3/AnimatedSprite2D
@onready var parede_que_sobe: TileMapLayer = $Parede_que_sobe
@onready var player: CharacterBody2D = $"../player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	animated_sprite_2d.animation = "pressed"
	if body.is_in_group("Player") and player.stop_time == false:
		parede_que_sobe.position.x = -120


func _on_area_2d_body_exited(body: Node2D) -> void:
	animated_sprite_2d.animation = "unpressed"
	if body.is_in_group("Player") and player.stop_time == false:
		parede_que_sobe.position.x = 120
	else:
		if body.is_in_group("Player"):
			await get_tree().create_timer(6.0).timeout
			parede_que_sobe.position.x = 10
