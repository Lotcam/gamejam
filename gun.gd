extends XRToolsPickable

@export var bullet : PackedScene
@export var bullet_speed : float = 10.0
var can_fire = false
var meat_t: Util.MEAT_STATE = Util.MEAT_STATE.RAW
signal fire

func action():
	super.action()
	
	if can_fire:
		_spawn_bullets()
		can_fire = false
		fire.emit()
		

func _spawn_bullets():
	if bullet:
		var new_bullet : RigidBody3D = bullet.instantiate()
		new_bullet.initialize(meat_t)
		if new_bullet:
			var spawn_global_transform = $SpawnPoint.global_transform
			add_child(new_bullet)
			new_bullet.global_transform = spawn_global_transform
			new_bullet.reparent(get_tree().current_scene, true)
			new_bullet.linear_velocity = spawn_global_transform.basis.x * bullet_speed

func loaded_dog(meat_type: Util.MEAT_STATE):
	match meat_type:
		Util.MEAT_STATE.RAW:
			meat_t = Util.MEAT_STATE.RAW
			$meshes/meat_raw.show()
			$meshes/meat_burned.hide()
			$meshes/meat_cooked.hide()
		Util.MEAT_STATE.COOKED:
			meat_t = Util.MEAT_STATE.COOKED
			$meshes/meat_raw.hide()
			$meshes/meat_burned.hide()
			$meshes/meat_cooked.show()
		Util.MEAT_STATE.BURNED:
			meat_t = Util.MEAT_STATE.BURNED
			$meshes/meat_raw.hide()
			$meshes/meat_burned.show()
			$meshes/meat_cooked.hide()
	can_fire = true
