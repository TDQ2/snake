extends Control

var level_scene := preload("res://Scenes/Level.tscn")

func _on_start_run_pressed() -> void:
	_start_level()
	
func _start_level() -> void:
	get_tree().change_scene_to_packed(level_scene)

func _on_quit_pressed() -> void:
	get_tree().quit(0)
