extends Node

enum SegmentId {BLACK_HEAVY, BLOOD_MOON, BLUE_RUSH, CYAN_BLADE, GREEN_COIN, PURPLE_CONSTRUCT, WHITE_HIVE, YELLOW_SYMMETRY}
enum Clan {BLACK, BLOOD, BLUE, CYAN, GREEN, PURPLE, WHITE, YELLOW, HEAVY, MOON, RUSH, BLADE, COIN, CONSTRUCT, HIVE, SYMMETRY}

var segment_textures = {
	SegmentId.BLACK_HEAVY: preload('res://Sprites/Player/black-heavy.png'),
	SegmentId.BLOOD_MOON: preload('res://Sprites/Player/blood-moon-10.png'),
	SegmentId.BLUE_RUSH: preload('res://Sprites/Player/blue-rush.png'),
	SegmentId.CYAN_BLADE: preload('res://Sprites/Player/cyan-blade.png'),
	SegmentId.GREEN_COIN: preload('res://Sprites/Player/green-coins.png'),
	SegmentId.PURPLE_CONSTRUCT: preload('res://Sprites/Player/purple-construct.png'),
	SegmentId.WHITE_HIVE: preload('res://Sprites/Player/white-hive.png'),
	SegmentId.YELLOW_SYMMETRY: preload('res://Sprites/Player/yellow-symmetry.png'),
}

# Cannot be const because of instiation inside the dictionary.
# If I really want const probably need to instantiate ahead of creation?
var segment_attrs: Dictionary[SegmentId, SegmentData] = {
	SegmentId.BLACK_HEAVY: SegmentData.new(SegmentId.BLACK_HEAVY, 'Black Heavy', segment_textures[SegmentId.BLACK_HEAVY], 3, [Clan.BLACK, Clan.HEAVY], "description"),
	SegmentId.BLOOD_MOON: SegmentData.new(SegmentId.BLOOD_MOON, 'Blood Moon', segment_textures[SegmentId.BLOOD_MOON], 2, [Clan.BLOOD, Clan.MOON], "description"),
	SegmentId.BLUE_RUSH: SegmentData.new(SegmentId.BLUE_RUSH, 'Blue Rush', segment_textures[SegmentId.BLUE_RUSH], 1, [Clan.BLUE, Clan.RUSH], "description"),
	SegmentId.CYAN_BLADE: SegmentData.new(SegmentId.CYAN_BLADE, 'Cyan Blade', segment_textures[SegmentId.CYAN_BLADE], 3, [Clan.CYAN, Clan.BLADE], "description"),
	SegmentId.GREEN_COIN: SegmentData.new(SegmentId.GREEN_COIN, 'Green Coin', segment_textures[SegmentId.GREEN_COIN], 2, [Clan.CYAN, Clan.BLADE], "description"),
	SegmentId.PURPLE_CONSTRUCT: SegmentData.new(SegmentId.PURPLE_CONSTRUCT, 'Purple Construct', segment_textures[SegmentId.PURPLE_CONSTRUCT], 1, [Clan.PURPLE, Clan.CONSTRUCT], "description"),
	SegmentId.WHITE_HIVE: SegmentData.new(SegmentId.WHITE_HIVE, 'White Hive', segment_textures[SegmentId.WHITE_HIVE], 3, [Clan.WHITE, Clan.HIVE], "description"),
	SegmentId.YELLOW_SYMMETRY: SegmentData.new(SegmentId.YELLOW_SYMMETRY, 'Yellow Symmetry', segment_textures[SegmentId.YELLOW_SYMMETRY], 2, [Clan.YELLOW, Clan.SYMMETRY], "description"),
}

func pick_random_segment_ids(count: int = 1) -> Array[SegmentId]:
	var segmentIds: Array[SegmentId] = []
	while segmentIds.size() < count:
		var segmentId = Data.SegmentId.values().pick_random() as Data.SegmentId
		if !segmentIds.has(segmentId):
			segmentIds.append(segmentId)
	print(segmentIds)
	return segmentIds
	

# Old dictionary format for data:
#{
		#'id': SegmentId.BLACK_HEAVY,
		#'name': 'Black Heavy',
		#'texture': "res://Sprites/Player/black-heavy.png",
		#'tier': 3,
		#'clans': [Clan.BLACK, Clan.HEAVY],
		#'description': "description"
	#}
	#SegmentId.BLOOD_MOON:{
		#'id': SegmentId.BLOOD_MOON,
		#'name': 'Blood Moon',
		#'texture': "res://Sprites/Player/blood-moon-10.png",
		#'tier': 2,
		#'clans': [Clan.BLOOD, Clan.MOON],
		#'description': "description"
	#},
	#SegmentId.BLUE_RUSH:{
		#'id': SegmentId.BLUE_RUSH,
		#'name': 'Blue Rush',
		#'texture': "res://Sprites/Player/blue-rush.png",
		#'tier': 1,
		#'clans': [Clan.BLUE, Clan.RUSH],
		#'description': "description"
	#},
	#SegmentId.CYAN_BLADE:{
		#'id': SegmentId.CYAN_BLADE,
		#'name': 'Cyan Blade',
		#'texture': "res://Sprites/Player/cyan-blade.png",
		#'tier': 3,
		#'clans': [Clan.CYAN, Clan.BLADE],
		#'description': "description"
	#},
	#SegmentId.GREEN_COIN:{
		#'id': SegmentId.GREEN_COIN,
		#'name': 'Green Coin',
		#'texture': "res://Sprites/Player/green-coins.png",
		#'tier': 2,
		#'clans': [Clan.GREEN, Clan.COIN],
		#'description': "description"
	#},
	#SegmentId.PURPLE_CONSTRUCT:{
		#'id': SegmentId.PURPLE_CONSTRUCT,
		#'name': 'Purple Construct',
		#'texture': "res://Sprites/Player/purple-construct.png",
		#'tier': 1,
		#'clans': [Clan.PURPLE, Clan.CONSTRUCT],
		#'description': "description"
	#},
	#SegmentId.WHITE_HIVE:{
		#'id': SegmentId.WHITE_HIVE,
		#'name': 'White Hive',
		#'texture': "res://Sprites/Player/white-hive.png",
		#'tier': 3,
		#'clans': [Clan.WHITE, Clan.HIVE],
		#'description': "description"
	#},
	#SegmentId.YELLOW_SYMMETRY:{
		#'id': SegmentId.YELLOW_SYMMETRY,
		#'name': 'Yellow Symmetry',
		#'texture': "res://Sprites/Player/yellow-symmetry.png",
		#'tier': 2,
		#'clans': [Clan.YELLOW, Clan.SYMMETRY],
		#'description': "description"
	#} 
