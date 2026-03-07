extends Area2D

func _ready():
	pass

func _on_body_entered(body):
	if body.has_method("die"):
		body.die()
		body.respawn()
