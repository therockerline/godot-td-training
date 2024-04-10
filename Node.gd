extends Node

@onready var path: Path2D = $Node2D/Path2D
@onready var pathFollow: PathFollow2D =  $Node2D/Path2D/PathFollow2D
@onready var line: Line2D = $Node2D/Line2D
@onready var speedDataLabel: DataLabel = $CanvasLayer/Control/GridContainer/SpeedDataLabel

enum Direction {R,L,U,D}
var base_speed = 50.0
var speed = 0.0
var multiplier = 100.0
func _ready():
	var points = createPath([
		Direction.D,
		Direction.D,
		Direction.L,
		Direction.D,
		Direction.R,
		Direction.R,
		Direction.U,
		Direction.U,
		Direction.U,
	])
	line.points = points
	for point in line.points:
		path.curve.add_point(point)
	var totalDistance = multiplier * (len(points) -1)
	var t = totalDistance / base_speed
	print(t)
	#var ratioPercent =   
	speed = t/Engine.physics_ticks_per_second
	speedDataLabel.set_label('Speed')
	pass
	
func _process(d):
	#print()
	pathFollow.progress_ratio += speed * d
	speedDataLabel.set_value(String.num(pathFollow.progress_ratio))
	#print(pathFollow.progress,' ',d)


func createPath(directions: Array[Direction]):
	var points: PackedVector2Array = []
	points.append(Vector2.ZERO)
	for direction in directions:
		var vect = Vector2.ZERO
		if direction == Direction.R:
			vect =  Vector2(1,0)
		elif direction == Direction.L:
			vect =  Vector2(-1,0)
		elif direction == Direction.U:
			vect = Vector2(0,-1)
		elif direction == Direction.D:
			vect = Vector2(0,1)
		vect *= (Vector2.ONE * multiplier)
		var lastPoint = points[len(points) -1]
		points.append(lastPoint + vect)
	var lastPoint = points[len(points) -1]
	if lastPoint != Vector2.ZERO:
		points.append(Vector2.ZERO)
	return points
