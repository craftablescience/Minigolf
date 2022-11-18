extends CanvasLayer

export(float) var MOUSE_SENSITIVITY: float = 0.2

const GOAL_SCENE: PackedScene = preload("res://scenes/Goal.tscn")

func load_level() -> void:
	var oldLevel = $LevelParent.get_node_or_null("Level")
	if oldLevel != null:
		$LevelParent.remove_child(oldLevel)
		oldLevel.queue_free()
		oldLevel = null
	var level: PackedScene = load("res://scenes/levels/Level0.tscn")
	var loadedLevel: Spatial = level.instance()
	loadedLevel.name = "Level"
	$LevelParent.add_child(level.instance())
	
	var goal = $LevelParent.get_node_or_null("Level/Goal/Goal")
	if goal == null:
		goal = level.instance()
		goal.name = "Goal"
		$LevelParent/Level/Goal.add_child(GOAL_SCENE.instance())
		$LevelParent/Level/Goal/Goal.connect("goal_reached", get_node("/root/Main"), "_on_game_goal_reached")

	goal.set_global_transform($LevelParent/Level/Goal.get_global_transform())
	$Player.set_global_transform($LevelParent/Level/Spawn.get_global_transform())

func fire() -> void:
	$Player.apply_central_impulse(Vector3(0,0,-2).rotated(Vector3(0,1,0), $CameraPivot.rotation.y))

func _physics_process(_delta: float) -> void:
	$CameraPivot.translation = $Player.translation

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("cam_zoomout"):
		$CameraPivot/Camera.translate_object_local(Vector3(0,0,0.2))

	if Input.is_action_pressed("cam_zoomin"):
		$CameraPivot/Camera.translate_object_local(Vector3(0,0,-0.2))

	if Input.is_action_just_pressed("cam_orbit"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	if Input.is_action_just_released("cam_orbit"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	if event is InputEventMouseMotion and Input.is_action_pressed("cam_orbit"):
		$CameraPivot.rotate_y(deg2rad(-event.relative.x * MOUSE_SENSITIVITY))
