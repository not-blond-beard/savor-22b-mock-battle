extends TextEdit



func _on_edit_text_changed_defense_batch():
	Settings.update_defense_batch_settings(self.text)
	
func _on_edit_text_changed_defense_command():
	Settings.update_defense_command_settings(self.text)

func _on_edit_text_changed_attack_batch():
	Settings.update_attack_batch_settings(self.text)
	
func _on_edit_text_changed_attack_command():
	Settings.update_attack_command_settings(self.text)
