extends Panel

class_name WinnerAlert

func show_winner(winner_code: int):
	if winner_code == Settings.ATTACK_TEAM_CODE:
		$defense_team.show()
	else:
		$attack_team.show()
		
	self.show()

func _on_change_scene_to_file_pressed():
	return get_tree().change_scene_to_file("res://scenes/levels/settings.tscn")
	
