extends ControlComponent
class_name TransformOnHover_CC

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

# Called when the node enters the scene tree for the first time.
func component_ready() -> void:
	pass # Replace with function body.

func update_offset_transform() -> void:
	controlParent.global_position = controlParent.global_position + progressPosition
	#zzz add starting calcs on where the control parent position offs are
	controlParent.rotation = progressRotation
	controlParent.scale = progressScale

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
	attempt_enable()

func on_mouse_entered() -> void:
	attempt_enable()
	
func on_focus_exited() -> void:
	attempt_disable()
	
func on_mouse_exited() -> void:
	attempt_disable()
