extends Label3D

func initialize(meat_type: Util.MEAT_STATE):
	match meat_type:
		Util.MEAT_STATE.RAW:
			self.text = "+ 0.5"
		Util.MEAT_STATE.COOKED:
			self.text = "+ 10"
		Util.MEAT_STATE.BURNED:
			self.text = "+ 1"

func _on_timer_kill_timeout() -> void:
	queue_free()
