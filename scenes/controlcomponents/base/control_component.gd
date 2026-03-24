extends Node
class_name ControlComponent

@export var buttonParent: Button

func init_existence_checks() -> bool:
	var tempParent: Node = get_parent()
	if buttonParent: tempParent = buttonParent
	
	if not tempParent:
		assert(false, "%s's target isn't a child of a Control Node!" % name)
	elif tempParent is not Control:
		assert(false, "%s's target isn't a Control Node!" % name)
	else:
		buttonParent = tempParent
		return true
	return false

func bind_signals() -> void:
	# Control
	if buttonParent.has_signal("mouse_entered"):
		buttonParent.mouse_entered.connect(on_mouse_entered)
	if buttonParent.has_signal("mouse_exited"):
		buttonParent.mouse_exited.connect(on_mouse_exited)
	
	# Button
	if buttonParent.has_signal("button_down"):
		buttonParent.button_down.connect(on_mouse_exited)
	if buttonParent.has_signal("button_up"):
		buttonParent.button_up.connect(on_mouse_exited)
	if buttonParent.has_signal("pressed"):
		buttonParent.pressed.connect(on_mouse_exited)
	if buttonParent.has_signal("toggled"):
		buttonParent.toggled.connect(on_mouse_exited)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_existence_checks()
	bind_signals()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_mouse_entered() -> void:
	pass

func on_mouse_exited() -> void:
	pass

func on_button_down() -> void:
	pass
	
func on_button_up() -> void:
	pass

func on_button_pressed() -> void:
	pass
	
func on_button_toggled() -> void:
	pass
