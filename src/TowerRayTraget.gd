extends RayCast2D
class_name TowerRayTarget
@onready var line: Line2D = $Line2D
var enemy: Enemy = null

func _ready():	
	line.add_point(Vector2.ZERO)

func update_target_position(enemy: Enemy):
	target_position =  enemy.global_position - global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemy != null:
		update_target_position(enemy)
		line.points[1] = target_position
	pass

func follow(enemy: Enemy):
	update_target_position(enemy)
	line.add_point(target_position)
	self.enemy = enemy
