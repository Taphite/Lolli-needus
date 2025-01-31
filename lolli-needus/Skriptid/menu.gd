extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Stseenid/levels.tscn")


func _on_quit_button_pressed():
	get_tree().quit()

func _on_controls_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Stseenid/controls.tscn")


func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Stseenid/settings.tscn")
