 class_name Timeline

signal new_event(event_info)

var events := {}


func _init(datafile: String) -> void:
	events = Utils.load_yaml(datafile)
	print(events)


func check_events(key: String) -> void:
	var event = events.get(key, null)
	if event:
		emit_signal("new_event", event)
