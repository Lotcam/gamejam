extends "res://gun.gd"

@onready var snap_zone = $SnapZone
var is_loaded = false

func on_magazine_loaded():
	$meshes.show()
	is_loaded = true
	$".".loaded_dog(snap_zone.picked_up_object.state)

func on_fire():
	if is_loaded:
		snap_zone.picked_up_object.queue_free()
		snap_zone.enabled = true
		$meshes.hide()
		is_loaded = false

func _on_snap_zone_has_picked_up(what: Variant) -> void:
	$AnimationPlayer.play("load_dog")
