extends Node2D

# Movement config
@export var speed := 75.0
@export var rotation_speed := PI / 64 # per second

var direction := Vector2.UP

# Segmentation config for animation / follow movement
var segment_spacing := 10
var samples_per_seg := 5 # should divide segment_spacing without a remainder
@warning_ignore("integer_division")
var sample_dist := segment_spacing / samples_per_seg

# Path data
var path: Array[Vector2] = [] #circular buffer

# Head path tracking
var last_recorded_position := Vector2.ZERO
var head_path_idx := 0
var progress: float
var should_move_all_segments := false

# Segment Data
var segments: Array[Segment] = []
var head: Segment

# preloads
@onready var black_heavy_scene: PackedScene = preload("res://Scenes/Children/black_heavy_segment.tscn")
@onready var blood_moon_scene: PackedScene = preload("res://Scenes/Children/blood_moon_segment.tscn")
@onready var blue_rush_scene: PackedScene = preload("res://Scenes/Children/blue_rush_segment.tscn")
@onready var cyan_blade_scene: PackedScene = preload("res://Scenes/Children/cyan_blade_segment.tscn")
@onready var green_coin_scene: PackedScene = preload("res://Scenes/Children/green_coin_segment.tscn")
@onready var purple_construct_scene: PackedScene = preload("res://Scenes/Children/purple_construct_segment.tscn")
@onready var white_hive_scene: PackedScene = preload("res://Scenes/Children/white_hive_segment.tscn")
@onready var yellow_symmetry_scene: PackedScene = preload("res://Scenes/Children/yellow_symmetry_segment.tscn")

func _ready() -> void:
	Game.player = self
	segments.append(black_heavy_scene.instantiate())
	segments.append(blood_moon_scene.instantiate())
	segments.append(blue_rush_scene.instantiate())
	segments.append(cyan_blade_scene.instantiate())
	segments.append(green_coin_scene.instantiate())
	segments.append(purple_construct_scene.instantiate())
	segments.append(white_hive_scene.instantiate())
	segments.append(yellow_symmetry_scene.instantiate())
	for segment in segments:
		add_child(segment)
		segment.connect("horizontal_bounce", horizontal_bounce)
		segment.connect("vertical_bounce", vertical_bounce)
	head = segments[0]
	segments[0].is_head = true
	
	path.resize(samples_per_seg * (segments.size() + 1))
	path.fill(Vector2.ZERO)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("test"):
		kill_segment(0)
	
	_update_head()
	_handle_movement_input()
	head.position += direction * speed * delta
	if head.position.distance_to(last_recorded_position) > sample_dist:
		_update_path(head)
	_move_following_segments()

func _update_head() -> void:
	if !segments[0].is_head:
		head = segments[0]
		head.is_head = true

func _handle_movement_input() -> void:
	if Input.is_action_pressed("left"):
		direction = direction.rotated(-rotation_speed)
	elif Input.is_action_pressed("right"):
		direction = direction.rotated(rotation_speed)
	head.rotation = direction.angle()

func _update_path(curr_head: Segment) -> void:
	last_recorded_position = curr_head.position
	head_path_idx = (head_path_idx + 1) % path.size()
	path[head_path_idx] = curr_head.position
	should_move_all_segments = should_move_all_segments if should_move_all_segments else head_path_idx >= samples_per_seg * segments.size()

func _move_following_segments() -> void:
	progress = clampf(head.position.distance_to(last_recorded_position) / sample_dist, 0, 1)
	for i in range(1, segments.size()):
		var segment = segments[i]
		if !segment.is_head and !segment.is_dead:
			if should_move_all_segments or head_path_idx >= i * samples_per_seg:
				var sample_offset = (i * samples_per_seg)
				var curr_segment_start_idx = posmod(head_path_idx - sample_offset, path.size())
				var curr_segment_next_idx = posmod(head_path_idx + 1 - sample_offset, path.size())
				segment.position = lerp(path[curr_segment_start_idx], path[curr_segment_next_idx], progress)
				
				# rotate torward next position, + 90 deg since +x is default facing
				segment.look_at(path[curr_segment_next_idx] + position)
				segment.rotation += PI / 2

func kill_segment(idx: int) -> void:
	var segment = segments[idx]
	for i in range(idx + 1, segments.size()):
		segments[i].position = segments[i - 1].position
	segments.remove_at(idx)
	segment.queue_free()



#Signal handlers
func horizontal_bounce() -> void:
	direction = direction.reflect(Vector2.RIGHT)

func vertical_bounce() -> void:
	direction = direction.reflect(Vector2.UP)
