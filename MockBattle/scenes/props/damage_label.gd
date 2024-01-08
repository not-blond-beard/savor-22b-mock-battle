extends Control

func set_damage(damage: int):
	var damage_label = $damage
	
	damage_label.text = str(damage)
	
	var tree = get_tree()
	
	await tree.create_timer(2.0).timeout
	
	queue_free()
