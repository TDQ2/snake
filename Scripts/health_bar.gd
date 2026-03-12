extends ProgressBar

func _physics_process(_delta: float) -> void:
	rotation = -get_parent().rotation
	global_position = get_parent().global_position - Vector2(0, -10)
