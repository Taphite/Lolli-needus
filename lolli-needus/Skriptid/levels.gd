extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func _on_back_pressed():
	get_tree().change_scene_to_file("res://Stseenid/menu.tscn")


func _on_tutorial_pressed():
	get_tree().change_scene_to_file("res://Stseenid/tutorial.tscn")


func _on_testing_pressed():
	get_tree().change_scene_to_file("res://Stseenid/testing.tscn")
