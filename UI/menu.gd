extends Control

@onready var settings = $MarginContainer/VBoxContainer/settings as Button
@onready var credits = $MarginContainer/VBoxContainer/credits as Button
@onready var settings_menu = $Settings as SettingsMenu
@onready var credits_menu = $Credits as Credits
@onready var margin_container =$MarginContainer  as MarginContainer
@onready var title = $Label as Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$MarginContainer/VBoxContainer/Button_continue.grab_focus()
	handle_connecting_signals()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
	
func handle_connecting_signals() -> void:
	credits.button_down.connect(_on_credits_pressed)
	settings.button_down.connect(_on_settings_pressed)
	settings_menu.exit_settings_menu.connect(_on_exit_settings_menu)
	credits_menu.exit_credits.connect(_on_exit_credits)
	

func _on_play_pressed() -> void:
	print("LOAD GAME SCENE")
	# TODO change to actual scene
	get_tree().change_scene_to_file("res://UI/how_to.tscn")


func _on_credits_pressed() -> void:
	margin_container.visible = false
	title.visible = false
	credits_menu.set_process(true)
	credits_menu.visible = true

func _on_settings_pressed() -> void:
	margin_container.visible = false
	title.visible = false
	settings_menu.set_process(true)
	settings_menu.visible = true
	
func _on_exit_settings_menu() -> void:
	margin_container.visible = true
	settings_menu.visible = false
	title.visible = true
	
func _on_exit_credits() -> void:
	margin_container.visible = true
	credits_menu.visibility_layer = false
	title.visible = true



func _on_exit_pressed() -> void:
	get_tree().quit()
