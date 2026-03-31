extends RefCounted
class_name SegmentData

var id: Data.SegmentId
var name: String
var texture: Resource
var tier: int
var clans: Array[Data.Clan]
var description: String
	
func _init(_id: Data.SegmentId, _name: String, _texture: Resource, _tier: int, _clans: Array[Data.Clan], _description: String) -> void:
	id = _id
	name = _name
	texture = _texture
	tier = _tier
	clans = _clans
	description = _description
