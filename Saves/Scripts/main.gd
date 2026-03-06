extends Node2D

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _setup_level() -> void:
	# Connect keys
	var coins = $level1.get_node_or_null("Coins")
	if coins:
		for enemy in coins.get_children():
			enemy.collected.connect(increase_score)
	
	
	# Connect enemies
	var enemies = $level1.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)

# Signal handlers

func _on_player_died(body):
	body.die()
	body.respawn()
	print("Player killed")
	
func increase_score() -> void:
	score += 1
	print(score)
