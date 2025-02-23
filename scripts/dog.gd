extends CharacterBody3D

@export var score: PackedScene

func feed(meat: Util.MEAT_STATE):
	Global.score_up(meat)
	print("score: " + str(Global.score))
	var new_score = score.instantiate()
	new_score.initialize(meat)
	if new_score:
		var spawn_global_transform = $spawn_score.global_transform
		add_child(new_score)
		new_score.global_transform = spawn_global_transform
		new_score.reparent(get_tree().current_scene, true)
	queue_free()

func _on_timer_feed_despawn_timeout() -> void:
	queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("bullet"):
		feed(body.meat_type)
		if body.has_method("despawn"): body.despawn()
