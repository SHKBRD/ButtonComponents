@tool
extends ControlComponent
class_name TransformOnHover_CC

@export_enum("On Click:0", "On Select:1") var trigger = 1:
	set(value):
		trigger = value
		notify_property_list_changed()
@export var differentiateHoverAndFocus: bool = false:
	set(value):
		differentiateHoverAndFocus = value
		notify_property_list_changed()
@export_enum("On Focus:0", "On Hover:1") var selectType = 0

@export var affectsCollision: bool = false
@export_group("Start Transform")
@export var startOffsetPosition: Vector2 = Vector2(0.0, 0.0)
@export var startOffsetRotation: float = 0.0
@export var startScale: Vector2 = Vector2i(1.0, 1.0)

@export_group("End Transform")
@export var endOffsetPosition: Vector2 = Vector2(0.0, 0.0)
@export var endOffsetRotation: float = 0.0
@export var endScale: Vector2 = Vector2i(1.0, 1.0)

@export_group("Tweening")
@export var tweenEasing: Tween.EaseType = Tween.EaseType.EASE_IN_OUT
@export var tweenTransition: Tween.TransitionType = Tween.TransitionType.TRANS_LINEAR
@export var tweenTime: float = 0.5

var progressPosition: Vector2 = startOffsetPosition
var progressRotation: float = startOffsetRotation
var progressScale: Vector2 = startScale

var selected: bool = false
var currentTween: Tween

func _validate_property(property: Dictionary) -> void:
	match property.name:
		"differentiateHoverAndFocus":
			if trigger != 1:
				property.usage = PROPERTY_USAGE_NO_EDITOR 
		"selectType":
			if not differentiateHoverAndFocus:
				property.usage = PROPERTY_USAGE_NO_EDITOR
		

# Called when the node enters the scene tree for the first time.
func component_ready() -> void:
	stack.assignedParent.offset_transform_enabled = true

func update_offset_transform() -> void:
	stack.combined_position_offset += progressPosition
	stack.combined_rotation_offset += progressRotation
	stack.combined_scale_offset *= progressScale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func component_process(delta: float) -> void:
	update_offset_transform()

func attempt_enable() -> void:
	if selected:
		return
	selected = true
	currentTween = create_tween()
	currentTween.set_ease(tweenEasing).set_trans(tweenTransition)
	currentTween.parallel().tween_property(self, "progressPosition", endOffsetPosition, tweenTime)
	currentTween.parallel().tween_property(self, "progressRotation", deg_to_rad(endOffsetRotation), tweenTime)
	currentTween.parallel().tween_property(self, "progressScale", endScale, tweenTime)

func attempt_disable() -> void:
	if not selected:
		return
	selected = false
	currentTween = create_tween()
	currentTween.set_ease(tweenEasing).set_trans(tweenTransition)
	currentTween.parallel().tween_property(self, "progressPosition", startOffsetPosition, tweenTime)
	currentTween.parallel().tween_property(self, "progressRotation", deg_to_rad(startOffsetRotation), tweenTime)
	currentTween.parallel().tween_property(self, "progressScale", startScale, tweenTime)

func on_focus_entered() -> void:
	if trigger==1 and (not differentiateHoverAndFocus or selectType==0):
		attempt_enable()

func on_mouse_entered() -> void:
	if trigger==1 and (not differentiateHoverAndFocus or selectType==1):
		attempt_enable()
	
func on_focus_exited() -> void:
	if trigger==1 and (not differentiateHoverAndFocus or selectType==0):
		attempt_disable()
	
func on_mouse_exited() -> void:
	if trigger==1 and (not differentiateHoverAndFocus or selectType==1):
		attempt_disable()
