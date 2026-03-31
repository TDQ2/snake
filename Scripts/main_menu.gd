extends Control

var shop_scene := preload("res://Scenes/Shop/shop.tscn")

func _on_start_run_pressed() -> void:
	_start_level()
	
func _start_level() -> void:
	get_tree().change_scene_to_packed(shop_scene)

func _on_quit_pressed() -> void:
	get_tree().quit(0)
