extends Node2D
class_name SlotItem
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var area: Area2D =  $SlotArea
@onready var coord_label: Label =  $Label
@onready var build_slot: Node2D = $BuildSlot
signal on_selected
signal on_collision

var coord
var _is_hover := false
var _is_empty := true
func _ready():
	coord = Vector2(position.x/50, position.y/50)
	coord_label.text = "{0}.{1}".format([position.x/50, position.y/50])
	pass

func _on_slot_area_mouse_entered():
	sprite.modulate = Color.GREEN
	sprite.play('hover' if _is_empty else 'hover_build')
	_is_hover = true
	pass # Replace with function body.


func _on_slot_area_mouse_exited():
	sprite.modulate = Color.WHITE
	_is_hover = false
	sprite.play('idle' if _is_empty else 'build')
	pass # Replace with function body.


func _on_slot_area_input_event(viewport, event, shape_idx):
	if _is_hover and event.is_action_type():
		var ev = event as InputEventMouseButton
		if ev.pressed:
			on_selected.emit()
	pass # Replace with function body.

func build_tower(tower: Tower):
	if _is_empty:
		_is_empty = false
		build_slot.add_child(tower)
		sprite.play('build')

func show_remove_option():
	pass
	
func remove_tower():
	if not _is_empty: 
		_is_empty = true
		build_slot.get_children()[0].queue_free()
		sprite.play('idle')
