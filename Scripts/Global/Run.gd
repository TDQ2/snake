extends Node

# Inner data class for type safety
class _SegmentCount:
	var inner: Dictionary[Data.SegmentId, int]

var current_gold := 100
var current_segments : Array[_SegmentCount] = []
