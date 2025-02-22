extends RigidBody3D


func _on_life_time_timeout():
	despawn()

func despawn():
	queue_free()
