extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $"."

@onready var audiostreams = get_node("/root/AudioStreams")

const SPEED = 340.0
const JUMP_VELOCITY = -930.0
var alive = true
var stop_time = false
var is_jumping = false



func _ready() -> void:
	audiostreams.walk_timer.one_shot = true
	audiostreams.walk_timer.wait_time = 0.25
	audiostreams.walk_timer.start()
	

func respawn():
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
	alive = true


func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("reset_level"):
		get_tree().reload_current_scene()
		
	if !alive:
		return

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		is_jumping = true
		#animated_sprite_2d.animation = "jumping"
		
	if Input.is_action_just_released("up"):
		player.velocity.y *= 0.5

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.animation = "idling"
		elif direction > 0 or direction < 0:
			animated_sprite_2d.animation = "running"
			if audiostreams.walk_timer.is_stopped():
				audiostreams.walk.play()
				audiostreams.walk_timer.start()
				
		if is_jumping:
			is_jumping = false
			audiostreams.land.play()
	else:
		animated_sprite_2d.animation = "jumping"
		
	# Stopping time
	
	if Input.is_action_just_pressed("stop_time") and !stop_time:
		stop_time = true
		audiostreams.timefreeze_whistle.play()
		await get_tree().create_timer(3.5).timeout
		audiostreams.timeunfreeze.play()
		await get_tree().create_timer(2.5).timeout
		stop_time = false

	move_and_slide()
	
	# Handles jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		audiostreams.jump.play()

	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1.0:
		animated_sprite_2d.flip_h = true
		

func die() -> void:
	animated_sprite_2d.animation = "hurting"
	alive = false
