extends Control

var level_scene := preload("res://Scenes/Level.tscn")
var seg_shop_button_scene := preload("res://Scenes/Shop/seg_shop_button.tscn")

func _ready() -> void:
	$PurchaseVBox/Gold.text = "Gold: " + str(Run.current_gold)
	_generate_shop_choices()

func _on_start_round_pressed() -> void:
	get_tree().change_scene_to_packed(level_scene)

func _generate_shop_choices() -> void:
	for button in $SelectionHBox.get_children():
		button.queue_free()
	var random_segment_ids := Data.pick_random_segment_ids(3)
	for segmentId in random_segment_ids:
		var button := seg_shop_button_scene.instantiate() as SegmentShopButton
		button.setup(Data.segment_attrs[segmentId])
		$SelectionHBox.add_child(button)

func _on_reroll_pressed() -> void:
	_generate_shop_choices()

# Setup reroll buttons
# pick 3 segments randomly from data, eventually tier logic lives here
# instantiate 3 SegShopButtons
# do any container based node setup - e.g. expand
# Pass either the entire segment or the enum name

# In the segment button init, take the segment_attr
# Update the label and texture
# store the segment attr for future use
