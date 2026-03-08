extends Area2D

# Called when something steps INTO the warmth zone
func _on_body_entered(body: Node2D):
	# Check if the thing that entered is in our "Player" group
	if "is_near_fire" in body:
		body.is_near_fire = true
		print("Player is warming up!")

# Called when something steps OUT OF the warmth zone
func _on_body_exited(body: Node2D):
	if "is_near_fire" in body:
		body.is_near_fire = false
		print("Player is getting cold again!")
