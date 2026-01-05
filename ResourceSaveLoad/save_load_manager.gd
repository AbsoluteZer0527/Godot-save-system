extends CanvasLayer

@export var player : Node2D

func _save() -> void:
	#save player
	var data = SceneData.new()
	data.player_position = player.global_position
	data.is_facing_left = player.get_child(0).flip_h;
	
	#save boxes 
	var boxes = get_tree().get_nodes_in_group("Box")
	for box in boxes:
		var box_scene = PackedScene.new()
		box_scene.pack(box)
		data.box_array.append(box_scene)
		
	ResourceSaver.save(data, "user://scene_data.tres")
	print("saved!")


func _load() -> void:
	#load player
	var data = ResourceLoader.load("user://scene_data.tres") as SceneData
	player.global_position = data.player_position
	player.get_child(0).flip_h = data.is_facing_left
	
	#remove current unsaved boxes
	for box in get_tree().get_nodes_in_group("Box"):
		box.queue_free()
	
	for box in data.box_array:
		var box_node = box.instantiate()
		get_tree().current_scene.add_child(box_node)
		box_node.freeze = true
		
	await get_tree().create_timer(0.1).timeout
	
	for box in get_tree().get_nodes_in_group("Box"):
			box.freeze = false
	print("loaded!")
