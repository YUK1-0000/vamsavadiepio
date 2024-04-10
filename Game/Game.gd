extends Node

signal game_start
signal game_over

@onready var world: Node2D = get_tree().root.get_node("World")
@onready var player: Player = world.get_node("Player")
@onready var enemies: Node2D = world.get_node("Enemies")
@onready var bullets: Node2D = world.get_node("Bullets")
@onready var spawn_timer: Timer = world.get_node("SpawnTimer")

var spawn_distance := 800
var spawn_rate := 1
var survival_time: float

const ENEMY_SCENE := preload("res://Enemy/enemy.tscn")

func _ready() -> void:
	game_start.connect(start)
	game_over.connect(over)
	spawn_timer.timeout.connect(spawn_enemy)

func _process(delta: float) -> void:
	survival_time += delta

func start() -> void:
	spawn_timer.start()

func over() -> void:
	spawn_timer.stop()
	for enemy in enemies.get_children():
		enemy.queue_free()
	#result_menu.show()

func spawn_enemy() -> void:
	var enemy: Enemy = ENEMY_SCENE.instantiate()
	enemy.global_position = player.global_position + Vector2.RIGHT.rotated(randf_range(0, TAU)) * spawn_distance
	enemies.add_child(enemy)

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
