class_name Credits

extends Control

@onready var exit_button = $Button as Button

signal exit_credits

func _ready():
	exit_button.button_down.connect(_on_exit_pressed)
	set_process(false)
	

func _on_exit_pressed() -> void:
	print("EXIT")
	exit_credits.emit()
	set_process(false)
