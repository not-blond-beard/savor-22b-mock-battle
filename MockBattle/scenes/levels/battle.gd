extends Node2D


const Player = preload("res://scenes/characters/player.gd")

var instance_map = {}

func _on_change_scene_pressed():
	return get_tree().change_scene_to_file("res://scenes/levels/settings.tscn")

func _ready():
	batch_characters_at_areas()
	activate_command(Settings.command_result_list)
	
	var code = GameHelper.get_winner_team_code(instance_map)
		
func activate_command(commands):
	for command in commands:
		var food: Player = instance_map[command.id].instance_node
		
		GameHelper.activate_skill(instance_map, food, command.skill_id)
		
func batch_characters_at_areas():
	var defnse_front_area = $defense_area/front/container
	var defnse_center_area = $defense_area/center/container
	var defnse_back_area = $defense_area/back/container
	
	var attack_front_area = $attack_area/front/container
	var attack_center_area = $attack_area/center/container
	var attack_back_area = $attack_area/back/container
	
	batch_characters_at_area(Settings.DEFENSE_TEAM_CODE, [defnse_front_area, defnse_center_area, defnse_back_area], Settings.defense_character_position)
	batch_characters_at_area(Settings.ATTACK_TEAM_CODE, [attack_front_area, attack_center_area, attack_back_area], Settings.attack_character_position)
	
func batch_characters_at_area(team: int, areas: Array, batchs: Array):
	for i in range(len(areas)):
		var area = areas[i]
		var characters = batchs[i]
	
		for character in characters:
			var food: Player = GameHelper.get_food_instance(character.type)
			
			instance_map[character.id] = {
				"area": i,
				"instance_node": food
			}
			
			food.set_team(team)
			area.add_child(food)

func get_winner_team_code(instance_map) -> int:
	var defense_team_total_health: int = 0 
	var attack_team_total_healath: int = 0
	
	for key in instance_map:
		var food: Player = instance_map[key].instance_node
		
		if food.get_team() == Settings.DEFENSE_TEAM_CODE:
			defense_team_total_health += food.get_health()
		else: 
			attack_team_total_healath += food.get_health()
			
	if defense_team_total_health > attack_team_total_healath:
		return Settings.DEFENSE_TEAM_CODE
	elif defense_team_total_health < attack_team_total_healath:
		return Settings.ATTACK_TEAM_CODE
	else:
		return 0




