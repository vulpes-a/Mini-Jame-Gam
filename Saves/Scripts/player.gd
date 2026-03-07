extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump: AudioStreamPlayer = $Jump
@onready var timefreeze_whistle: AudioStreamPlayer = $"Timefreeze&whistle"
@onready var timeunfreeze: AudioStreamPlayer = $Timeunfreeze
@onready var player: CharacterBody2D = $"."

const SPEED = 340.0
const JUMP_VELOCITY = -930.0
var alive = true
var stop_time = false

func respawn():
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
	alive = true

func _physics_process(delta: float) -> void:
	
	if !alive:
		return
		
	if Input.is_action_just_pressed("reset_level"):
		get_tree().reload_current_scene()

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		#animated_sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump.play()
		
	if Input.is_action_just_released("up"):
		velocity.y *= 0.5

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.animation = "idling"
		elif direction != 0:
			animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "jumping"
		
	# Stopping time
	
	if Input.is_action_just_pressed("stop_time") and !stop_time:
		stop_time = true
		timefreeze_whistle.play()
		await get_tree().create_timer(3.5).timeout
		timeunfreeze.play()
		await get_tree().create_timer(2.5).timeout
		stop_time = false

	move_and_slide()

	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0:
		animated_sprite_2d.flip_h = true
		

func die() -> void:
	animated_sprite_2d.animation = "hurting"
	alive = false
