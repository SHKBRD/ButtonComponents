extends Node
class_name ControlComponentStack

@export var assignedParent: Control

var combined_position_offset: Vector2
var combined_rotation_offset: float
var combined_scale_offset: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_existence_checks()

func init_existence_checks() -> bool:
	var tempParent: Node = get_parent()
	if assignedParent: tempParent = assignedParent
	
	if not tempParent:
		assert(false, "%s's target isn't a child of a Control Node!" % name)
	elif tempParent is not Control:
		assert(false, "%s's target isn't a Control Node!" % name)
	else:
		assignedParent = tempParent
		return true
	return false


func apply_transform_offset() -> void:
	assignedParent.offset_transform_position = combined_position_offset
	assignedParent.offset_transform_rotation = combined_rotation_offset
	assignedParent.offset_transform_scale = combined_scale_offset

func clear_transform_offset() -> void:
	combined_position_offset = Vector2.ZERO
	combined_rotation_offset = 0
	combined_scale_offset = Vector2.ONE

func process_child_components(delta: float) -> void:
	var children: Array[ControlComponent] = []
	children.assign(get_children())
	for child: ControlComponent in children:
		child.component_process(delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	process_child_components(delta)
	apply_transform_offset()
	clear_transform_offset()
