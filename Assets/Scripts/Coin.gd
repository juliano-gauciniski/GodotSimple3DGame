extends Area3D

signal coinCollected

func _physics_process(delta):
	rotate_y(deg_to_rad(3))


func _on_body_entered(body):
	if body.name == "Player":
		$Timer.start()
		$AnimationPlayer.play("bounce")
		


func _on_timer_timeout():
	emit_signal("coinCollected")
	#delete the node
	queue_free()
