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
@export var easing: Tween.EaseType
@export var transition: Tween.TransitionType
@export var time: float

@export_group("Trigger Functions")
@export var growTriggerFuncName: Array[String]
@export var shrinkTriggerFuncName: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
