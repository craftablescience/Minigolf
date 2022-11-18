extends Spatial

signal goal_reached

func _on_area_body_entered(body):
	self.emit_signal("goal_reached")
