extends Node2D

func _ready() -> void:
	visible = false

func _physics_process(_delta: float) -> void:
	global_rotation = 0
	global_position = get_parent().global_position + Vector2(-5.0, -10.0)

func show_health(duration: float = 1.0) -> void:
	visible = true
	$VisibleTimer.start(duration)

func _on_visible_timer_timeout() -> void:
	visible = false
