extends RigidBody3D

var meat_type: Util.MEAT_STATE

func initialize(type: Util.MEAT_STATE):
	meat_type = type
	match meat_type:
		Util.MEAT_STATE.RAW:
			$meshes/meat_raw.show()
			$meshes/meat_burned.hide()
			$meshes/meat_cooked.hide()
		Util.MEAT_STATE.COOKED:
			$meshes/meat_raw.hide()
			$meshes/meat_burned.hide()
			$meshes/meat_cooked.show()
		Util.MEAT_STATE.BURNED:
			$meshes/meat_raw.hide()
			$meshes/meat_burned.show()
			$meshes/meat_cooked.hide()

func _on_life_time_timeout():
	despawn()

func despawn():
	queue_free()
