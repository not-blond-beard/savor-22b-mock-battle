extends Control

func draw_contents(character_id: int, skill_id: int, frame: int, description: String):
	$panel/character_id.text = str(character_id)
	$panel/skill_id.text = str(skill_id)
	$panel/need_frame.text = str(frame)
	$panel/description.text = description
