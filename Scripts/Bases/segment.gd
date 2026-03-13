extends Node2D
class_name Segment

signal horizontal_bounce
signal vertical_bounce
signal died(segment: Segment)

# Player management
var is_dead := false
var is_head := false

# Game Stats
var max_health := 100.0
var curr_health := 100.0

func _on_body_entered(body: Node2D) -> void:
	if is_head:
		if body.is_in_group("horizontal_wall"):
			emit_signal("horizontal_bounce")
		elif body.is_in_group("vertical_wall"):
			emit_signal("vertical_bounce")

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemies"):
		_take_damage(20.0)

func _take_damage(amount: float) -> void:
	curr_health -= amount
	if curr_health <= 0:
		emit_signal("died", self)
		return
	$HealthBar/ProgressBar.value = curr_health / max_health
	$HealthBar.show_health()
