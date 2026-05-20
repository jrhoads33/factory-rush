extends Node

signal tick

var _timer: Timer


func _ready() -> void:
	_timer = Timer.new()
	add_child(_timer)
	_timer.wait_time = 1.0
	_timer.timeout.connect(_on_timer_timeout)
	_timer.start()


func _on_timer_timeout() -> void:
	tick.emit()
