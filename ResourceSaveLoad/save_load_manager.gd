extends CanvasLayer

@export var player : Node2D

func _save() -> void:
	var data = SceneData.new()
	data.player_position = player.global_position
	data.is_facing_left = player.get_child(0).flip_h;
	
	ResourceSaver.save(data, "user://scene_data.tres")
	print("saved!")


func _load() -> void:
	var data = ResourceLoader.load("user://scene_data.tres") as SceneData
	player.global_position = data.player_position
	player.get_child(0).flip_h = data.is_facing_left
	
	print("loaded!")
