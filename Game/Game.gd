extends Node

@onready var world: Node2D = get_tree().root.get_node("World")
@onready var wall: StaticBody2D = world.get_node("Wall")
@onready var player: Player
@onready var enemies: Node2D = world.get_node("Enemies")
@onready var bullets: Node2D = world.get_node("Bullets")
@onready var spawn_timer: Timer = world.get_node("SpawnTimer")

var spawn_distance := 800
var spawn_rate := 1
var survival_time: float
var is_started: bool

const PLAYER_SCENE := preload("res://Characters/Player/player.tscn")
const ENEMY_SCENE := preload("res://Characters/Enemy/enemy.tscn")

signal game_start
signal game_pause
signal game_resume
signal game_over
signal game_reset

func _ready() -> void:
	game_start.connect(start)
	game_pause.connect(pause)
	game_resume.connect(resume)
	game_over.connect(over)
	game_reset.connect(reset)
	spawn_timer.timeout.connect(spawn_enemy)

func _process(delta: float) -> void:
	player = world.get_node("Player")
	if is_started:
		survival_time += delta

func start() -> void:
	is_started = true
	spawn_timer.start()
	wall.process_mode = Node.PROCESS_MODE_DISABLED

func pause() -> void:
	get_tree().paused = true

func resume() -> void:
	get_tree().paused = false

func over() -> void:
	pause()
	is_started = false
	survival_time = 0
	spawn_timer.stop()

func reset() -> void:
	world.remove_child(player)
	spawn_player()
	for enemy: Enemy in enemies.get_children():
		enemy.queue_free()
	for bullet: Bullet in bullets.get_children():
		bullet.queue_free()
	wall.process_mode = Node.PROCESS_MODE_INHERIT
	resume()

func spawn_player() -> void:
	var p: Player = PLAYER_SCENE.instantiate()
	world.add_child(p)

func spawn_enemy() -> void:
	var e: Enemy = ENEMY_SCENE.instantiate()
	e.global_position = player.global_position + Vector2.RIGHT.rotated(randf_range(0, TAU)) * spawn_distance
	enemies.add_child(e)

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
