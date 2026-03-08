extends Node2D

# Nodes in Main.tscn
@onready var level_container: Node2D = $LevelContainer
@onready var player: CharacterBody2D = $Player
@onready var audiostreams: Node = get_node("/root/AudioStreams")

# Track current level number
var current_level := 0
var levels := [
	"res://Saves/levels/level_0.tscn",
	"res://Saves/levels/level_1.tscn",
	"res://Saves/levels/level_2.tscn"
]

func _ready() -> void:
	# Play theme once
	if not audiostreams.maintheme.playing:
		audiostreams.maintheme.play()
	if not audiostreams.freezetheme.playing:
		audiostreams.freezetheme.play()
		audiostreams.freezetheme.stream_paused = true

	# Load first level
	load_level(levels[current_level])


# Load a level by path
func load_level(path: String) -> void:
	# Remove previous level
	for child in level_container.get_children():
		child.queue_free()

	# Load new level scene
	var level_res = load(path)
	if not level_res:
		push_error("Cannot load level: %s" % path)
		return

	var level = level_res.instantiate()
	level_container.add_child(level)

	# Move player to the SpawnPoint inside the level
	var spawn = level.get_node_or_null("SpawnPoint")
	if spawn:
		player.global_position = spawn.global_position
		player.velocity = Vector2.ZERO

	# Setup spikes to connect signals
	_setup_level(level)


# Setup spikes in the current level
func _setup_level(level: Node) -> void:
	var spikes = level.get_node_or_null("Spikes")
	if spikes:
		for spike in spikes.get_children():
			if not spike.body_entered.is_connected(_on_player_died):
				spike.body_entered.connect(_on_player_died)


# Signal handler: called when player hits a spike
func _on_player_died(body) -> void:
	if body.has_method("die"):
		body.die()
		body.respawn()
	print("Player killed")


# Call this to load the next level
func load_next_level() -> void:
	current_level += 1
	if current_level >= levels.size():
		print("All levels completed!")
		return
	load_level(levels[current_level])
