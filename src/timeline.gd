class_name Timeline

signal new_tick(ticks)
signal new_minute(minute)
signal new_hour(hour)
signal new_day(day)

export(int) var ticks := 0

export(int) var minute := 0 setget ,get_minute
export(int) var hour := 0 setget ,get_hour
export(int) var day := 0 setget ,get_day

export(int) var default_ticks := 100
export(int) var ticks_per_minute := 6000


func tick(to_tick:=default_ticks) -> void:
	ticks += to_tick
	emit_signal("new_tick", ticks)
	if not ticks % ticks_per_minute:
		emit_signal("new_minute", get_minute())
		minute = get_minute()
		if not self.minute % 60:
			emit_signal("new_hour", get_hour())
			hour = get_hour()
		if not self.hour % 24:
			emit_signal("new_day", get_day())
			day = get_day()


func get_minute() -> int:
	# warning-ignore:integer_division
	return ticks / ticks_per_minute


func get_hour() -> int:
	# warning-ignore:integer_division
	return self.minute / 60


func get_day() -> int:
	# warning-ignore:integer_division
	return self.hour / 24


func get_date() -> Dictionary:
	return {
		"day": self.day,
# warning-ignore:integer_division
		"hour": self.hour - (self.day * 24),
		"minute": self.ticks / ticks_per_minute - (self.hour * 60),
		"second": self.ticks % ticks_per_minute / (ticks_per_minute / 60)
	}
