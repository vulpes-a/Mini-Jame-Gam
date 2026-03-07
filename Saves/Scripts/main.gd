extends Node2D
@onready var level_container = $LevelContainer

func load_level(path):
	for child in level_container.get_children():
		child.queue_free()

	var level = load(path).instantiate()
	level_container.add_child(level)
	
func _ready() -> void:
	load_level("res://Saves/levels/level_0.tscn")

func _process(_delta: float) -> void:
	pass


func _setup_level() -> void:
	# Connect spikes
	var spikes = $level_0.get_node_or_null("Spikes")
	if spikes:
		for spike in spikes.get_children():
			spike.player_died.connect(_on_player_died)


# Signal handler
func _on_player_died(body) -> void:
	body.die()
	body.respawn()
	print("Player killed")
