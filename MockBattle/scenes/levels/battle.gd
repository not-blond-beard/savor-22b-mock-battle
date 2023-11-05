extends Node2D

var jjajang = preload("res://scenes/characters/jjajang.tscn")
var jjambbong = preload("res://scenes/characters/jjambbong.tscn")
var cake = preload("res://scenes/characters/cake.tscn")

const Player = preload("res://scenes/characters/player.gd")

var instance_map = {}

func _on_change_scene_pressed():
	return get_tree().change_scene_to_file("res://scenes/levels/settings.tscn")

func _ready():
	batch_characters_at_areas()
	activate_command(Settings.command_result_list)
	
func activate_skill(id, food: Player, skill_id: int):
	match skill_id:
		1:
			food.skill_1(instance_map)
			print(id + "가 1번 스킬을 시전했습니다.")
		2:
			food.skill_2(instance_map)
			print(id + "가 2번 스킬을 시전했습니다.")
		_:
			print("not found")
			
	
func activate_command(commands):
	for command in commands:
		var food: Player = instance_map[command.id].instance_node
		
		activate_skill(str(command.id), food, command.skill_id)
		
	
func batch_characters_at_areas():
	var defnse_front_area = $defense_area/front/container
	var defnse_center_area = $defense_area/center/container
	var defnse_back_area = $defense_area/back/container
	
	var attack_front_area = $attack_area/front/container
	var attack_center_area = $attack_area/center/container
	var attack_back_area = $attack_area/back/container
	
	batch_characters_at_area(0, [defnse_front_area, defnse_center_area, defnse_back_area], Settings.defense_character_position)
	batch_characters_at_area(1, [attack_front_area, attack_center_area, attack_back_area], Settings.attack_character_position)
	
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
	
func batch_characters_at_area(team: int, areas: Array, batchs: Array):
	for i in range(len(areas)):
		var area = areas[i]
		var characters = batchs[i]
	
		
		for character in characters:
			var food: Player = get_food_instance(character.type)
			
			instance_map[character.id] = {
				"area": i,
				"instance_node": food
			}
			
			food.set_team(team)
			area.add_child(food)
