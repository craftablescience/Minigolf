extends Control

signal load_level_pressed
signal fire_pressed

func _on_load_level_pressed():
	self.emit_signal("load_level_pressed")

func _on_fire_pressed():
	self.emit_signal("fire_pressed")
