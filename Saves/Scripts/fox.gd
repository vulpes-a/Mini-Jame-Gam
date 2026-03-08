extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $player

const SPEED = 300.0
var direction = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if player.stop_time:
		return
		
	position.x += direction * SPEED * delta



func _on_timer_timeout() -> void:
	
	if player.stop_time:
		return
		
	direction *= -1
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
	


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()
		body.respawn()
