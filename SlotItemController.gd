extends Node2D
class_name SlotItem
@onready var sprite: Sprite2D = $Image
@onready var area: Area2D =  $SlotArea
@onready var coord_label: Label =  $Label
@onready var position_label: Label =  $Position

func _ready():
	coord_label.text = "{0}.{1}".format([position.x/50, position.y/50])
	position_label.text = "{0}.{1}".format([global_position.x, global_position.y])
	area.connect('mouse_entered', _on_slot_area_mouse_entered)
	area.connect('mouse_exited', _on_slot_area_mouse_exited)
	area.connect('area_entered', _on_slot_area_mouse_entered)
	area.connect('area_exited', _on_slot_area_mouse_exited)
	pass

func _on_slot_area_mouse_entered():
	print('enter')
	sprite.modulate = Color.GREEN
	pass # Replace with function body.


func _on_slot_area_mouse_exited():
	sprite.modulate = Color.WHITE
	print('exit')
	pass # Replace with function body.

