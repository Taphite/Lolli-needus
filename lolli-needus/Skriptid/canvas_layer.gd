extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	$stamina.text = str(round(Sv.player_stamina))
	$health.text = str(round(Sv.player_health))
	$money.text = str(Sv.money) + "$"
