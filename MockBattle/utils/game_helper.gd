extends Node

const Player = preload("res://scenes/characters/player.gd")

var jjajang = preload("res://scenes/characters/jjajang.tscn")
var jjambbong = preload("res://scenes/characters/jjambbong.tscn")
var cake = preload("res://scenes/characters/cake.tscn")

func activate_skill(instance_map, food: Player, skill_id: int):
	match skill_id:
		1:
			food.skill_1(instance_map)
		2:
			food.skill_2(instance_map)
		_:
			print("not found")

func get_food_instance(type):
	match type:
		Settings.character_type.CAKE:
			return cake.instantiate()
		Settings.character_type.JJAJANG:
			return jjajang.instantiate()
		Settings.character_type.JJAMBBONG:
			return jjambbong.instantiate()
		_:
			print("not found")

