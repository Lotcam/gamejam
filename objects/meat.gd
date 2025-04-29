extends XRToolsPickable

@onready var timer_cook: Timer = $TimerCooked
@onready var timer_burned: Timer = $TimerBurned
var state: Util.MEAT_STATE = Util.MEAT_STATE.RAW

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.has_method("is_grill"):
		cooking()

func cooking():
	print("cooking...")
	timer_cook.start()
	timer_burned.start()

func cooked():
	state = Util.MEAT_STATE.COOKED
	#self.add_to_group("Magazine")
	$meshes/meat_raw.hide()
	$meshes/meat_cooked.show()

func burned():
	#self.remove_from_group("Magazine")
	state = Util.MEAT_STATE.BURNED
	$meshes/meat_burned.show()
	$meshes/meat_cooked.hide()

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
