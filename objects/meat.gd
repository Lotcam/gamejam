extends XRToolsPickable

@onready var timer_cook: Timer = $TimerCooked
@onready var timer_burned: Timer = $TimerBurned

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.has_method("is_grill"):
		cooking()

func cooking():
	print("cooking...")
	timer_cook.start()
	timer_burned.start()

func cooked():
	print("cooked!")

func burned():
	print("BURNED!")


func _on_timer_cooked_timeout() -> void:
	cooked()


func _on_timer_burned_timeout() -> void:
	burned()


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.has_method("is_grill"):
		stop_cooking()

func stop_cooking():
	print("stopped cooking")
	timer_burned.stop()
	timer_cook.stop()
