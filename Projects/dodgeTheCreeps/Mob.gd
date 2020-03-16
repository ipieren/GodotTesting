extends RigidBody2D

export var min_speed = 150
export var max_speed = 250
var mob_types = ["walk", "swim", "fly"]

func _ready() -> void:
	$AnimatedSprite.animation = mob_types[randi()%mob_types.size()]


func _on_Visibility_screen_exited() -> void:
	queue_free()
