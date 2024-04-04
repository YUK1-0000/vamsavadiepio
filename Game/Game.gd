extends Node

@onready var world: Node2D = get_tree().root.get_node("World")
@onready var main_menu: Control = world.get_node("MainMenu")
@onready var enemies: Node2D = world.get_node("Enemies")
@onready var bullets: Node2D = world.get_node("Bullets")
@onready var spawn_timer: Timer = world.get_node("SpawnTimer")

var player: Player
var spawn_distance := 800
var survival_time: float

const PLAYER_SCENE := preload("res://Player/player.tscn")
const ENEMY_SCENE := preload("res://Enemy/enemy.tscn")

func _ready() -> void:
	spawn_timer.timeout.connect(spawn_enemy)

func _process(delta: float) -> void:
	survival_time += delta

func game_start() -> void:
	player = PLAYER_SCENE.instantiate()
	world.add_child(player)
	spawn_timer.start()

func game_over() -> void:
	spawn_timer.stop()
	for enemy in enemies.get_children():
		enemy.queue_free()
	main_menu.show()

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy() -> void:
	var enemy: Enemy = ENEMY_SCENE.instantiate()
	enemy.global_position = player.global_position + Vector2.RIGHT.rotated(randf_range(0, TAU)) * spawn_distance
	enemy.hp_max += survival_time
	enemies.add_child(enemy)
