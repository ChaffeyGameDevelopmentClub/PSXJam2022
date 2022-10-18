extends ShipEntity

func _on_Hurtbox_area_entered(area):
	var projectile = area.get_parent()
	if projectile.is_in_group("enemy"):
		take_damage(projectile.damage) 
	print(self.current_hull_integrity)
	print(self.current_shield_integrity)
