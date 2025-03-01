extends CharacterBody2D

const speed = 30
var curr_state = SIDE_LEFT
var health = 100
var dir = Vector2.RIGHT
var start_pos

var is_roam = true
var is_chat = false
var is_draining = false

var player
var player_can_chat = false

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready() -> void:
	randomize()
	start_pos = position
	
	

func _physics_process(delta: float) -> void:
	if health < 100 and !is_draining:
		health += .01
	if curr_state == 0 or curr_state == 1:
		$AnimatedSprite2D.play("idle")
	elif curr_state == 2 and !is_chat:
		if dir.x == -1:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("walk_l")
		if dir.x == 1:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("walk_r")
		if dir.y == -1:
			$AnimatedSprite2D.play("walk_u")
		if dir.y == 1:
			$AnimatedSprite2D.play("walk_d")
	if is_roam:
		match curr_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose_dir([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)
	if player_can_chat and Input.is_action_just_pressed("chat"):
		print("chatting")
		is_roam = false
		is_chat = true
		$AnimatedSprite2D.play("idle")
	if player_can_chat and Input.is_action_just_pressed("eat"):
		print("eating")
		is_roam = false
		is_draining = true
		$AnimatedSprite2D.play("died")
	if is_draining:
		reduce_health(.5)
		
func choose_dir(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	if !is_chat:
		velocity = dir * speed
		move_and_slide()
		


func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		player_can_chat = true

func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_can_chat = false
		is_roam = true
		is_chat = false
		is_draining = false

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose_dir([5, 1, 1.5])
	curr_state = choose_dir([IDLE, NEW_DIR, MOVE])

func reduce_health(amount):
	print(health)
	health -= amount
	if health <= 0:
		die()

func die():
	is_roam = false
	is_chat = false
	$AnimatedSprite2D.play("died")
	# Wait here for animation to end?
	queue_free()
	print("NPC died")


func _on_dialogue_dialogue_finished():
	is_chat = false
	is_roam = true
	pass # Replace with function body.
