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
			return SkillSettings.new("가드", 3)
		1:
			return food.skill_1_settings
		2:
			return food.skill_2_settings
		_:
			print("not found")

static func get_food_instance(type):

	match type:
		Settings.character_type.CAKE:
			var cake = preload("res://scenes/characters/cake.tscn")
			return cake.instantiate()
		Settings.character_type.JJAJANG:
			var jjajang = preload("res://scenes/characters/jjajang.tscn")
			return jjajang.instantiate()
		Settings.character_type.JJAMBBONG:
			var jjambbong = preload("res://scenes/characters/jjambbong.tscn")
			return jjambbong.instantiate()
		Settings.character_type.RED_GINSENG_JUICE:
			var red_ginseng = preload("res://scenes/characters/red_ginseng_juice.tscn")
			return red_ginseng.instantiate()
		Settings.character_type.SEASONED_BELLFLOWER_ROOT:
			var seasoned_bellflower_root = preload("res://scenes/characters/seasoned_bellflower_root.tscn")
			return seasoned_bellflower_root.instantiate()
		Settings.character_type.MALA_XIANG_GUO:
			var mala_xiang_guo = preload("res://scenes/characters/mala_xiang_guo.tscn")
			return mala_xiang_guo.instantiate()
		Settings.character_type.MILK_SHAKE:
			var milk_shake = preload("res://scenes/characters/milk_shake.tscn")
			return milk_shake.instantiate()
		Settings.character_type.MALA_TANG:
			var mala_tang = preload("res://scenes/characters/mala_tang.tscn")
			return mala_tang.instantiate()
		Settings.character_type.KUNG_PAO_CHICKEN:
			var kung_pao_chicken = preload("res://scenes/characters/kung_pao_chicken.tscn")
			return kung_pao_chicken.instantiate()
		Settings.character_type.STIR_FRIED_FISH_CAKE:
			var stir_fried_fish_cake = preload("res://scenes/characters/stir_fried_fish_cake.tscn")
			return stir_fried_fish_cake.instantiate()
		_:
			print("not found")

