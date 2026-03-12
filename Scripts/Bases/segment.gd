extends Node2D
class_name Segment

var is_dead := false
var is_head := false
var health := 100.0

signal horizontal_bounce
signal vertical_bounce

func _on_body_entered(body: Node2D) -> void:
	if is_head:
		if body.is_in_group("horizontal_wall"):
			emit_signal("horizontal_bounce")
		elif body.is_in_group("vertical_wall"):
			emit_signal("vertical_bounce")


func _on_area_entered(area: Area2D) -> void:
	print(area)
	if area.is_in_group("enemies"):
		_take_damage(10.0)

func _take_damage(amount: float) -> void:
	health -= amount
	print(health)
