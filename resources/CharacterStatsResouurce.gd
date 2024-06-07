class_name CharacterStats extends Resource

enum MovingMode {CONSTANT, ACCELERATION}
@export var moving_mode: MovingMode
@export var speed: int
@export var acceleration: int
@export var friction: int

@export var max_hp: int
@export var hp: int
@export var hp_regen: float

@export var exp: int

@export var fire_rate: int
@export var bullet_spread: float
@export var multishot: float
@export var recoil: int
@export var penetration: float = INF
@export var knock_back: int
@export var damage: int
@export var crit_rate: float
@export var crit_dmg: float
