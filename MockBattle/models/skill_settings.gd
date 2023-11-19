extends Object

class_name SkillSettings

var frame: int
# 시전 필요 프레임
var persistent_turn: int
# 공격이 유지되는 턴
var target_direction: int
# 공격 방향, 0: 하단 | 1: 중단

func _init(_frame, _persistent_turn = -1, _target_direction = 0):
	frame = _frame
	persistent_turn = _persistent_turn
	target_direction = _target_direction
