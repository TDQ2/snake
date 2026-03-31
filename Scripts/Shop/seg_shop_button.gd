extends Button
class_name SegmentShopButton

var segmentData: SegmentData

func setup(_segmentData: SegmentData) -> void:
	segmentData = _segmentData
	$VBoxContainer/Label.text = segmentData.name
	$VBoxContainer/TextureRect.texture = segmentData.texture
