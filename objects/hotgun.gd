extends XRToolsPickable

@export var bullet : PackedScene
@export var bullet_speed : float = 10.0
var can_fire = true

func action():
	action()
	
	if can_fire:
		_spawn_bullets()
		can_fire = false
		$Cooldown.start()

func _spawn_bullets():
	if bullet:
		var new_bullet : RigidBody3D = bullet.instantiate()
		if new_bullet:
			new_bullet.set_as_toplevel(true)
			add_child(new_bullet)
			new_bullet.transform = $SpawnPoint.global_transform
			new_bullet.linear_velocity = new_bullet.transform.basis.z * bullet_speed

func _on_cooldown_timeout():
	can_fire = true
