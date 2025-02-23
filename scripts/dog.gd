extends CharacterBody3D

func feed(meat: Util.MEAT_STATE):
	Global.score_up(meat)
	print("score: " + str(Global.score))
	queue_free()

func _on_timer_feed_despawn_timeout() -> void:
	queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("bullet"):
		feed(body.meat_type)
		if body.has_method("despawn"): body.despawn()
