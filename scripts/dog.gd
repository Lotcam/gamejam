extends CharacterBody3D

# Minimum speed of the mob in meters per second.
@export var min_speed = 5
# Maximum speed of the mob in meters per second.
@export var max_speed = 6

var moving = true

@onready var movement = $Movement

func _physics_process(_delta):
    if moving:
        move_and_slide()
    
func feed():
    print("fed doggo")
    #TODO: score up
    queue_free()

func _on_timer_feed_despawn_timeout() -> void:
    queue_free()


func _on_area_3d_body_entered(body: Node3D) -> void:
    if body.is_in_group("bullet"):
        feed()
        if body.has_method("despawn"): body.despawn()

func initialize(start_position, pivot_position):
    look_at_from_position(start_position, pivot_position, Vector3.UP)
    rotate_y(randf_range(-PI / 4, PI / 4))
    
    # Movement
    var random_speed = randi_range(min_speed, max_speed)
    velocity = Vector3.FORWARD * random_speed
    velocity = velocity.rotated(Vector3.UP, rotation.y)


func stop_movement():
    moving = false
    velocity = Vector3.ZERO


func _on_visible_on_screen_notifier_3d_screen_exited():
    queue_free()
