extends Node2D
class_name SlotItem
@onready var sprite: Sprite2D = $Image
@onready var area: Area2D =  $SlotArea
@onready var position_label: Label =  $Label
func _ready():
	position_label.text = "{0}.{1}".format([position.x/50, position.y/50])
	area.connect('mouse_entered', _on_slot_area_mouse_entered)
	area.connect('mouse_exited', _on_slot_area_mouse_exited)
	pass

func _on_slot_area_mouse_entered():
	print('enter')
	sprite.modulate = Color.GREEN
	pass # Replace with function body.


func _on_slot_area_mouse_exited():
	sprite.modulate = Color.WHITE
	print('exit')
	pass # Replace with function body.

