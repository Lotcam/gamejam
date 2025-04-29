extends Node3D

var xr_interface: XRInterface

@export var dog_scene : PackedScene
@export var count = 0

func _ready():
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialized successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
	else:
		print("OpenXR not initialized, please check if your headset is connected")

func increase_spawn_speed():
	if Global.dogs % 3 == 0:
		if $DogTimer.wait_time >= 1:
			$DogTimer.wait_time -= 1

	

func _on_dog_timer_timeout():
		var dog = dog_scene.instantiate()
		var dog_spawn_location = get_node("SpawnPath/SpawnLocation")
		dog_spawn_location.progress_ratio = randf()

		var pivot_position = $Pivot.position
		dog.initialize(dog_spawn_location.position, pivot_position)

		add_child(dog)
		
		Global.dogs += 1
		increase_spawn_speed()

#func _on_dog_dead():
	#count -= 1
