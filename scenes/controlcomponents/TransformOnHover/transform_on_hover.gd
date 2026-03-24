extends ControlComponent
class_name TransformOnHover_CC

@export_group("Start Transform")
@export var startOffsetPosition: Vector2
@export var startOffsetRotation: float
@export var startScale: Vector2 = Vector2i(1.0, 1.0)

@export_group("End Transform")
@export var endOffsetPosition: Vector2
@export var endOffsetRotation: float
@export var endScale: Vector2 = Vector2i(1.0, 1.0)

@export_group("Tweening")
@export var tweenEasing: Tween.EaseType
@export var tweenTransition: Tween.TransitionType
@export var tweenTime: float

var selected: bool = false
var currentTween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func attempt_enable() -> void:
	if selected:
		return
	selected = false
	currentTween = create_tween()
	currentTween.set_ease(tweenEasing).set_trans(tweenTransition)
	currentTween.parallel().tween_property(self, "position", endOffsetPosition, tweenTime)
	currentTween.parallel().tween_property(self, "rotation", endOffsetRotation, tweenTime)
	currentTween.parallel().tween_property(self, "scale", endScale, tweenTime)

func attempt_disable() -> void:
	if not selected:
		return
	selected = false
	currentTween = create_tween()
	currentTween.set_ease(tweenEasing).set_trans(tweenTransition)
	currentTween.parallel().tween_property(self, "position", startOffsetPosition, tweenTime)
	currentTween.parallel().tween_property(self, "rotation", startOffsetRotation, tweenTime)
	currentTween.parallel().tween_property(self, "scale", startScale, tweenTime)

func on_focus_entered() -> void:
	attempt_enable()

func on_mouse_entered() -> void:
	attempt_enable()
	
func on_focus_exited() -> void:
	attempt_disable()
	
func on_mouse_exited() -> void:
	attempt_disable()
