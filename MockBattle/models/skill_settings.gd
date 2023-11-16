extends Object

class_name SkillSettings

var frame: int
var persistent_turn: int
var target_direction: int

func _init(_frame, _persistent_turn = -1, _target_direction = -1):
	frame = _frame
	persistent_turn = _persistent_turn
	target_direction = _target_direction
