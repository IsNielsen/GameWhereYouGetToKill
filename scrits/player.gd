extends CharacterBody2D

@export var player_id = 1
@export var points = 0

var speed = 100

var player_state

@onready var label: Label = $Label


func _ready():
	$AnimatedSprite2D.modulate = Color(1, 0, 0)
func _process(delta: float) -> void:
	label.text = "%d"%points

func _physics_process(delta: float) -> void:
	var dir = Input.get_vector("left_%s"% [player_id],"right_%s"%[player_id],"up_%s"%[player_id],"down_%s"%[player_id])
	
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
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("walk_l")
		if dir.x == 1:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("walk_r")
		if dir.y == -1:
			$AnimatedSprite2D.play("walk_u")
		if dir.y == 1:
			$AnimatedSprite2D.play("walk_d")
		
