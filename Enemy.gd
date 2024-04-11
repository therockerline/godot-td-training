class_name Enemy
extends PathFollow2D

@export var path: Path2D
@export var speed: float = 10.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d):
	if path.curve.get_baked_length() > 1:
		var totalDistance = path.curve.get_baked_length()
		var ratio_at_second = speed / totalDistance
		var delta_ratio_at_second = ratio_at_second * d
		progress_ratio += delta_ratio_at_second		
		if progress_ratio == 1.0:
			queue_free()
