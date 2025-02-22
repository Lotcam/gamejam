extends RigidBody3D


func _on_life_time_timeout():
	queue_free()
