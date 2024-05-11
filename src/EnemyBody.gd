extends Node2D
class_name EnemyBody

@onready var life_rect = $CanvasLayer/Node2D/LifeRect
@onready var dmg_rect = $CanvasLayer/Node2D/DmgRect

func _ready():
	dmg_rect.scale.x = 0

func _process(d):
	$CanvasLayer/Node2D.position = position

func draw_life(life):
    if life == 0.0:
        dmg_rect.scale.x = 1
        queue_free()
        death.emit()
    else:
        var perc = 1.0 - ((max_life * life) / life_rect.size.x)
        dmg_rect.scale.x = perc