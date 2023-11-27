extends Node

class_name GameHelper

static func is_probability_success(percent: int) -> bool:
	return randf() < (float(percent) / 100.0)
	
static func calculate_percentage(original: int, percentage: int) -> float:
	var difference = original * (float(percentage) / 100.0)
	return difference

static func get_skill(food: Player, skill_id: int):
	match skill_id:
		0:
			return food.skill_guard
		1:
			return food.skill_1
		2:
			return food.skill_2
		_:
			print("not found")
			
static func get_skill_settings(food: Player, skill_id: int):
	match skill_id:
		0: 
			return SkillSettings.new(0)
		1:
			return food.skill_1_settings
		2:
			return food.skill_2_settings
		_:
			print("not found")

static func get_food_instance(type):
	var jjajang = preload("res://scenes/characters/jjajang.tscn")
	var jjambbong = preload("res://scenes/characters/jjambbong.tscn")
	var cake = preload("res://scenes/characters/cake.tscn")
	var red_ginseng = preload("res://scenes/characters/red_ginseng_juice.tscn")

	match type:
		Settings.character_type.CAKE:
			return cake.instantiate()
		Settings.character_type.JJAJANG:
			return jjajang.instantiate()
		Settings.character_type.JJAMBBONG:
			return jjambbong.instantiate()
		Settings.character_type.RED_GINSENG_JUICE:
			return red_ginseng.instantiate()
		_:
			print("not found")

