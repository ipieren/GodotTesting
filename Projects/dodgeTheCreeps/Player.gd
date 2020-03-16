extends Area2D

signal hit

export var speed = 400	#how fast the player will move
var screen_size	#size of the game window

func _ready() -> void:
	screen_size = get_viewport_rect().size
	#hide()
	
#every player needs some basic functions to work on i.e.
# 1. get input
# 2. move in a certain direction
# 3. play the appropriate animation


func _process(delta: float) -> void:
	var velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		
	#moving the player in the direction
	if velocity.length() > 0:
		velocity = velocity.normalized()*speed #this means no fast diagonal movement
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	#clamping for the screen boundary
	position += velocity*delta
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y,0,screen_size.y)
	
	#adding the animation part
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
		
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		print(velocity.y)
		$AnimatedSprite.flip_v = velocity.y < 0

#advanced functions of a player:
#1. detecting collisions from enemies
func _on_Player_body_entered(body: Node) -> void:
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

