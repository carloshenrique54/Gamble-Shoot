extends CharacterBody2D

const SPEED = 300.0
var last_dir := "down"

func _physics_process(delta: float) -> void:
	var directionX := Input.get_axis("ui_left", "ui_right")
	var directionY := Input.get_axis("ui_up", "ui_down")

	if directionX != 0:
		directionY = 0
	elif directionY != 0:
		directionX = 0

	var dir := Vector2(directionX, directionY)

	if dir != Vector2.ZERO:
		match dir:
			Vector2(1, 0):
				last_dir = "right"
			Vector2(-1, 0):
				last_dir = "left"
			Vector2(0, 1):
				last_dir = "down"
			Vector2(0, -1):
				last_dir = "up"

	velocity = dir * SPEED

	var prev_velocity = velocity
	move_and_slide()

	var blocked = (dir != Vector2.ZERO and velocity == Vector2.ZERO)

	if blocked:
		$spr_Player.play("idle_" + last_dir)
	elif dir != Vector2.ZERO:
		$spr_Player.play("walk_" + last_dir)
	else:
		$spr_Player.play("idle_" + last_dir)
