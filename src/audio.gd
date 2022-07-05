class_name Audio
extends Node


func one_shot(track: String, from_position := 0.0, volume := 1.0) -> void:
	var stream_player = AudioStreamPlayer.new()
	stream_player.volume_db = linear2db(volume)
	add_child(stream_player)
	var random_stream = AudioStreamRandomPitch.new()
	random_stream.random_pitch = 1.0
	random_stream.audio_stream = load(track)
	stream_player.stream = random_stream
	stream_player.connect("finished", stream_player, "queue_free")
	stream_player.play(from_position)
