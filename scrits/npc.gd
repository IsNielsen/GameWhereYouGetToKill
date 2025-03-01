extends CharacterBody2D

const speed = 30
var curr_state = SIDE_LEFT

var dir = Vector2.RIGHT
var start_pos

var is_roam = true
var is_chat = false

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
	
func _process(delta: float) -> void:
	if curr_state == 0  or curr_state == 1:
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
				dir = choose_dir([Vector2.RIGHT,Vector2.UP,Vector2.LEFT,Vector2.DOWN])
			MOVE:
				move(delta)
	if Input.is_action_just_pressed("chat"):
		print("chatting")
		is_roam = false
		is_chat = true
		$AnimatedSprite2D.play("idle")
		
func choose_dir(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	if !is_chat:
		position += dir * speed * delta


func _on_chat_detection_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player = body
		player_can_chat = true

func _on_chat_detection_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_can_chat = false

func _on_timer_timeout() -> void:
	$Timer.wait_time = choose_dir([5,1,1.5])
	curr_state = choose_dir([IDLE, NEW_DIR, MOVE])
