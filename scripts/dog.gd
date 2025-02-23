extends CharacterBody3D

# Minimum speed of the mob in meters per second.
@export var min_speed = 2
# Maximum speed of the mob in meters per second.
@export var max_speed = 6
@export var score: PackedScene

var moving = true
var count = 0

@onready var movement = $Movement

func _physics_process(_delta):
	if moving:
		move_and_slide()

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
	despawn()

func _on_timer_feed_despawn_timeout() -> void:
	despawn()

func despawn():
	queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("bullet"):
		feed(body.meat_type)
		if body.has_method("despawn"): body.despawn()

func initialize(start_position, pivot_position):
	look_at_from_position(start_position, pivot_position, Vector3.UP)
	rotate_y(randf_range(-PI / 4, PI / 4))
	if Global.dogs >= 12:
		$Timer_feed_despawn.wait_time = 7
	
	# Movement
	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)


func stop_movement():
	moving = false
	velocity = Vector3.ZERO


#func _on_visible_on_screen_notifier_3d_screen_exited():
	#queue_free()
