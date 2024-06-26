class_name Grid
extends Node2D

@export var width: int = 12
@export var height: int = 12
@export var cell_size: int = 128

var grid: Dictionary = {}
# Called when the node enters the scene tree for the first time.

@export var show_debug: bool = false
func generateGrid() :
	for x in width:
		for y in height:
			grid[Vector2(x,y)] = null
			if show_debug:
				var rect = ReferenceRect.new()
				rect.position = gridToWorld(Vector2(x,y))
				rect.size = Vector2(cell_size, cell_size)
				rect.editor_only = false
				$Debug.add_child(rect)
				var label = Label.new()
				label.position = gridToWorld(Vector2(x,y))
				label.text = str(Vector2(x,y))
				$Debug.add_child(label)
			
func gridToWorld(_pos: Vector2) -> Vector2:
	return _pos * cell_size

func worldToGrid(_pos: Vector2) -> Vector2:
	return floor(_pos / cell_size)
	

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
