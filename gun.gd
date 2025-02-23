extends XRToolsPickable

@export var bullet : PackedScene
@export var bullet_speed : float = 10.0
var can_fire = false
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
		if new_bullet:
			var spawn_global_transform = $SpawnPoint.global_transform
			add_child(new_bullet)
			new_bullet.global_transform = spawn_global_transform
			new_bullet.reparent(get_tree().current_scene, true)
			new_bullet.linear_velocity = spawn_global_transform.basis.x * bullet_speed

func loaded_dog():
	can_fire = true
