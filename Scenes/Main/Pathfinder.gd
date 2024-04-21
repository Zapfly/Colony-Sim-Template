class_name Pathfinder
extends Node

var aStar = AStar2D.new()
@onready var main = get_tree().root.get_node("Main")
@onready var grid: Grid = main.get_node("Grid")

const DIRECTIONS = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func addPoints():
	var curID = 0
	for point in grid.grid:
		aStar.add_point(curID, grid.gridToWorld(point))
		curID += 1
		
func getPointID(gridPoint: Vector2) -> int:
	return aStar.get_closest_point(grid.gridToWorld(gridPoint))
	
func getWorldID(worldPoint: Vector2) -> int:
	return aStar.get_closest_point(worldPoint)
	
func getIDWorldPos(_id: int) -> Vector2:
	return aStar.get_point_position(_id)
	
func getIDGridPos(_id: int) -> Vector2:
	var worldPos = getIDWorldPos(_id)
	return grid.worldToGrid(worldPos)

func connectPoint(_point: Vector2):
	var _pointID = getPointID(_point)
	for direction in DIRECTIONS:
		var neighbour = _point + direction
		var neighbourID = getPointID(neighbour)
		if grid.grid.has(neighbour) and grid.grid[neighbour] == null: 
			aStar.connect_points(_pointID, neighbourID)
			
func disconnectPoint(_point: Vector2):
	var _pointID = getPointID(_point)
	for direction in DIRECTIONS:
		var neighbour = _point + direction
		var neighbourID = getPointID(neighbour)
		aStar.disconnect_points(_pointID, neighbourID)

func connectAllPoints():
	for point in grid.grid:
		connectPoint(point)

func initialize():
	addPoints()
	connectAllPoints() 
	
func getPath(_pointA: Vector2, _pointB: Vector2):
	var aID = getPointID(_pointA)
	var bID = getPointID(_pointB)
	return aStar.get_point_path(aID, bID)
