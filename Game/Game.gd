extends Node

@onready var world: Node2D = get_tree().root.get_node("World")
@onready var main_menu: CanvasLayer = world.get_node("MainMenu")
@onready var pause_menu: CanvasLayer = world.get_node("PauseMenu")
@onready var result_menu: CanvasLayer = world.get_node("ResultMenu")
@onready var enemies: Node2D = world.get_node("Enemies")
@onready var bullets: Node2D = world.get_node("Bullets")
@onready var spawn_timer: Timer = world.get_node("SpawnTimer")

var player: Player
var spawn_distance := 800
var spawn_rate := 1
var survival_time: float

const PLAYER_SCENE := preload("res://Player/player.tscn")
const ENEMY_SCENE := preload("res://Enemy/enemy.tscn")

func _ready() -> void:
	spawn_timer.timeout.connect(spawn_enemy)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		pause_menu.show()
		world.paused = true
	survival_time += delta

func start() -> void:
	player = PLAYER_SCENE.instantiate()
	world.add_child(player)
	spawn_timer.start()

func over() -> void:
	spawn_timer.stop()
	for enemy in enemies.get_children():
		enemy.queue_free()
	result_menu.show()

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy() -> void:
	print("Enemy Spawn")
	var enemy: Enemy = ENEMY_SCENE.instantiate()
	enemy.global_position = player.global_position + Vector2.RIGHT.rotated(randf_range(0, TAU)) * spawn_distance
	enemies.add_child(enemy)
