extends Node2D

export (PackedScene) var Mob
var score

func _ready():
	randomize()


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()




func _on_MobTimer_timeout() -> void:
	$MobPath/MobSpawnLocation.offset = randi()
	
	var mob = Mob.instance()
	add_child(mob)
	
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	
	mob.position = $MobPath/MobSpawnLocation.position
	
	direction += rand_range(-PI/4,PI/4)
	mob.rotation = direction
	
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotation(direction)


func _on_ScoreTimer_timeout() -> void:
	score += 1


func _on_StartTimer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
