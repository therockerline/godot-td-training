extends Node2D
class_name SlotController
var slots: Array = []
@onready var slot_instance = load("res://Slot.tscn")
var tslot = []
var multi = 0
signal on_slot_selected

func addPoint(point, dir):
	var p = point + (dir * multi)
	if !tslot.has(p):
		tslot.append(p)
	
func updateSlot(points: Array, baked, multiplier: float):
	multi = multiplier
	tslot = []
	for point in points:		
		addPoint(point,Vector2.UP)
		addPoint(point,Vector2.DOWN)
		addPoint(point,Vector2.LEFT)
		addPoint(point,Vector2.RIGHT)
		addPoint(point,Vector2.UP + Vector2.RIGHT)
		addPoint(point,Vector2.UP + Vector2.LEFT)
		addPoint(point,Vector2.DOWN + Vector2.RIGHT)
		addPoint(point,Vector2.DOWN + Vector2.LEFT)
	tslot = tslot.filter(
		func(p): 
			if points.has(p):
				return false
			else:		
				for baked_point in baked:
					if p.distance_to(baked_point) <= multiplier*0.8:
						return  false
				return true
	)
	print(tslot)
		

	var res = tslot.filter(func(e): return !slots.has(e))
	var del = slots.filter(func(e): return !tslot.has(e))
	
	for point in res:
		#print('draw', point)
		var slot: SlotItem = slot_instance.instantiate()
		var position = point
		slot.position = position
		slot.connect('on_selected',func(): on_slot_selected.emit(slot))
		add_child(slot)
		
	for slot_pos in del:
		var children = get_children()
		var founded_children = children.filter(func(e): return e.position == slot_pos)
		if len(founded_children) == 1:			
			var child = founded_children[0]
			remove_child(child)			
			child.queue_free()

	slots = tslot
	#print(res,'\n', points,'\n', slots)
		
	
