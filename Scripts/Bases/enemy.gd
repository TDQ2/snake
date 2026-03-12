extends Area2D
class_name Enemy

@onready var player := Game.player
@onready var health_bar := $HealthBar

# Movement config
@export var speed := 50.0
var direction := Vector2.ZERO

# Knockback config
var knockback_max_speed := 300
var knockback_direction := Vector2.ZERO
var knockback_decay := 500.0

# Calculated Values
var chase_velocity: Vector2
var knockback_velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
	direction = (player.head.global_position - global_position).normalized()
	look_at(player.head.global_position)
	chase_velocity = direction * speed
	position += chase_velocity * delta + knockback_velocity * delta
	knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_decay * delta)

func _on_area_entered(area: Area2D) -> void:
	print("hit player")
	if area.is_in_group("segment"):
		_apply_knockback((global_position - area.global_position).normalized())

func _apply_knockback(knockback_dir: Vector2) -> void:
	knockback_direction = knockback_dir
	knockback_velocity = knockback_direction * knockback_max_speed

func _on_body_entered(body: StaticBody2D) -> void:
	if body.is_in_group("horizontal_wall"):
		_apply_knockback(direction.reflect(Vector2.UP))
	elif body.is_in_group("vertical_wall"):
		_apply_knockback(direction.reflect(Vector2.RIGHT))
