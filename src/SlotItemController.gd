extends Node2D
class_name SlotItem
@onready var sprite: Sprite2D = $Image
@onready var area: Area2D =  $SlotArea
@onready var coord_label: Label =  $Label
@onready var build_slot: Node2D = $BuildSlot
signal on_selected
signal on_collision

var coord
var _is_hover := false
func _ready():
	coord = Vector2(position.x/50, position.y/50)
	coord_label.text = "{0}.{1}".format([position.x/50, position.y/50])
	pass

func _on_slot_area_mouse_entered():
	sprite.modulate = Color.GREEN
	_is_hover = true
	pass # Replace with function body.


func _on_slot_area_mouse_exited():
	sprite.modulate = Color.WHITE
	_is_hover = false
	pass # Replace with function body.


func _on_slot_area_input_event(viewport, event, shape_idx):
	if _is_hover and event.is_action_type():
		var ev = event as InputEventMouseButton
		if ev.pressed:
			on_selected.emit()
	pass # Replace with function body.

func build_tower(tower: Tower):
	if build_slot.get_child_count() == 0:
		build_slot.add_child(tower)
