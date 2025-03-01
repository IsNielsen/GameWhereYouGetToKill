extends CanvasModulate

@onready var animation := $AnimationPlayer
@onready var timer := $Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var time_passed =  timer.wait_time - timer.time_left
	var animation_frame := remap(time_passed, 0, timer.wait_time, 0, 24)
	animation.play('day_night')
	animation.seek(animation_frame)
