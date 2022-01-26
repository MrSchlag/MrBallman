extends Line2D

var active = false

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if active:
		global_position = Vector2.ZERO
		global_rotation = 0
		add_point(get_parent().global_position)
		while get_point_count() > 50:
			remove_point(0)
	else:
		if get_point_count() > 0:
			remove_point(0)


func Activate(activeArg : bool) -> void:
	active = activeArg
	
