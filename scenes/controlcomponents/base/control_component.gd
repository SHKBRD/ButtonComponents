extends Node
class_name ControlComponent

@export var controlParent: Control

func init_existence_checks() -> bool:
	var tempParent: Node = get_parent()
	if controlParent: tempParent = controlParent
	
	if not tempParent:
		assert(false, "%s's target isn't a child of a Control Node!" % name)
	elif tempParent is not Control:
		assert(false, "%s's target isn't a Control Node!" % name)
	else:
		controlParent = tempParent
		return true
	return false

func bind_signals() -> void:
	# Control
	if controlParent.has_signal("mouse_entered"):
		controlParent.mouse_entered.connect(on_mouse_entered)
	if controlParent.has_signal("mouse_exited"):
		controlParent.mouse_exited.connect(on_mouse_exited)
	if controlParent.has_signal("focus_entered"):
		controlParent.focus_entered.connect(on_focus_entered)
	if controlParent.has_signal("focus_exited"):
		controlParent.focus_exited.connect(on_focus_exited)
	if controlParent.has_signal("gui_input"):
		controlParent.gui_input.connect(on_gui_input)
	
	# Button
	if controlParent.has_signal("button_down"):
		controlParent.button_down.connect(on_button_down)
	if controlParent.has_signal("button_up"):
		controlParent.button_up.connect(on_button_up)
	if controlParent.has_signal("pressed"):
		controlParent.pressed.connect(on_button_pressed)
	if controlParent.has_signal("toggled"):
		controlParent.toggled.connect(on_button_toggled)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_existence_checks()
	bind_signals()
	component_ready()

func component_ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	component_process(delta)

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
