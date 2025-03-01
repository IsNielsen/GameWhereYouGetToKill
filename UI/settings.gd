class_name SettingsMenu
extends Control

@onready var exit_button = $MarginContainer/VBoxContainer/Exit_Button as Button

signal exit_settings_menu

func _ready():
	exit_button.button_down.connect(_on_exit_pressed)
	set_process(false)


func _on_exit_pressed() -> void:
	print("EXIT")
	exit_settings_menu.emit()
	set_process(false)
