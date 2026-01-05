extends CanvasLayer

@export var player: Node2D

func _save() -> void:
	var data = SceneData.new()
	data.player_position
