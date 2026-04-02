extends Node
class_name ControlComponent

@export var stack: ControlComponentStack

func init_existence_checks() -> bool:
	var tempStack: Node = get_parent()
	if stack: tempStack = stack
	
	if not tempStack:
		assert(false, "%s's target isn't a child of a Control Node!" % name)
	elif tempStack is not ControlComponentStack:
		assert(false, "%s's target isn't a Control Node!" % name)
	else:
		stack = tempStack
		return true
	return false

func bind_signals() -> void:
	# Control
	if stack.assignedParent.has_signal("mouse_entered"):
		stack.assignedParent.mouse_entered.connect(on_mouse_entered)
	if stack.assignedParent.has_signal("mouse_exited"):
		stack.assignedParent.mouse_exited.connect(on_mouse_exited)
	if stack.assignedParent.has_signal("focus_entered"):
		stack.assignedParent.focus_entered.connect(on_focus_entered)
	if stack.assignedParent.has_signal("focus_exited"):
		stack.assignedParent.focus_exited.connect(on_focus_exited)
	if stack.assignedParent.has_signal("gui_input"):
		stack.assignedParent.gui_input.connect(on_gui_input)
	
	# Button
	if stack.assignedParent.has_signal("button_down"):
		stack.assignedParent.button_down.connect(on_button_down)
	if stack.assignedParent.has_signal("button_up"):
		stack.assignedParent.button_up.connect(on_button_up)
	if stack.assignedParent.has_signal("pressed"):
		stack.assignedParent.pressed.connect(on_button_pressed)
	if stack.assignedParent.has_signal("toggled"):
		stack.assignedParent.toggled.connect(on_button_toggled)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_existence_checks()
	bind_signals()
	component_ready()

func component_ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#component_process(delta)

func component_process(delta: float) -> void:
	pass


# Control signals

func on_mouse_entered() -> void:
	pass

func on_mouse_exited() -> void:
	pass

func on_focus_entered() -> void:
	pass

func on_focus_exited() -> void:
	pass

func on_gui_input(event: InputEvent) -> void:
	pass
	

# Button signals

func on_button_down() -> void:
	pass
	
func on_button_up() -> void:
	pass

func on_button_pressed() -> void:
	pass
	
func on_button_toggled(toggled_on: bool) -> void:
	pass
