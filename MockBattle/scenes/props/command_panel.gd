extends Node2D

func change_command_count(count: int):
	$container/command_count.text = "{0} 개".format([str(count)])

func draw_command_list(commands, instance_map):
	var command = preload("res://scenes/props/skill_command.tscn")
	
	change_command_count(len(commands))
	
	for cmd in commands:
		var character = instance_map[cmd.id].instance_node
		var skill_settings: SkillSettings = GameHelper.get_skill_settings(character, cmd.skill_id)
		var child = command.instantiate()
		child.draw_contents(
			cmd.id,
			cmd.skill_id,
			skill_settings.frame,
			skill_settings.description
		)
		
		$container/ScrollContainer/HBoxContainer.add_child(
			child
		)

func scroll_to_element(index):
	var scrollContainer = $container/ScrollContainer
	
	scrollContainer.set_deferred("scroll_horizontal", 300 * index)
	
