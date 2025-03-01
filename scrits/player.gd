extends CharacterBody2D

var speed = 100

var player_state

func _physics_process(delta: float) -> void:
	var dir = Input.get_vector("left","right","up","down")
	
	if dir.x == 0 and dir.y == 0:
		player_state = "idle"
	elif dir.x != 0 or dir.y != 0:
		player_state = "walking"	
	velocity = dir * speed
	move_and_slide()
	
	animate(dir)
	
func animate(dir):
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	if player_state == "walking":
		if dir.x == -1:
			$AnimatedSprite2D.play("walk_l")
		if dir.x == 1:
			$AnimatedSprite2D.play("walk_r")
		if dir.y == -1:
			$AnimatedSprite2D.play("walk_u")
		if dir.y == 1:
			$AnimatedSprite2D.play("walk_d")
		
