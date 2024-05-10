class_name Enemy
extends PathFollow2D

@export var path: Path2D
@export var speed: float = 10.0
@export var max_life = 5.0
@export var life = 5.0
@onready var sprite = $Sprite2D
@onready var life_rect = $CanvasLayer/Node2D/LifeRect
@onready var dmg_rect = $CanvasLayer/Node2D/DmgRect
signal death

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(d):
	$CanvasLayer/Node2D.position = position
	if path.curve.get_baked_length() > 1:
		var totalDistance = path.curve.get_baked_length()
		var ratio_at_second = speed / totalDistance
		var delta_ratio_at_second = ratio_at_second * d
		progress_ratio += delta_ratio_at_second
		if progress_ratio == 1.0:
			queue_free()

func shot(dmg: float):
	var l = life - dmg
	life = l if l > 0 else 0
	if life == 0:
		dmg_rect.scale.x = 1
		queue_free()
		death.emit()
	else:
		var perc = 1.0 -  ((max_life * life) / life_rect.size.x)
		dmg_rect.scale.x = perc
