extends Node

var player : Node2D

func _ready() -> void:
	var screen_size = DisplayServer.screen_get_size()
	get_window().size = screen_size
