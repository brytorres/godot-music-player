extends Node

export var fade_time = 10
export var play_time = 30
export var max_volume = -15
export var transition_type = 0 # Linear 
var current_song = 0
var next_song = 1
var audiostream

var songs = [
	'beepage',
	'dance_of_the_satellites',
	'digital_sunset',
	'high_tech_city',
	'ocean_technology'
]

func _ready():
	start_music()
	
func set_audio_stream(song):
	audiostream = load('res://assets/audio/music/' + songs[song] + '.wav')
	get_node("MusicPlayer").set_stream(audiostream)

func start_music():
	set_audio_stream(current_song)
	$MusicPlayer.play()
	$PlayTime.start(play_time)

func switch_song():
	if next_song < songs.size():
		current_song += 1
		next_song += 1
	else: 
		current_song = 0
		next_song = 1
 
func fade(fade_type):
	if fade_type == 'in':
		start_music()
		$FadeIn.interpolate_property($MusicPlayer, "volume_db", -80, max_volume, fade_time, transition_type, Tween.EASE_IN, 0)
		$FadeIn.start()
	if fade_type == 'out':
		$FadeOut.interpolate_property($MusicPlayer, "volume_db", max_volume, -80, fade_time, transition_type, Tween.EASE_IN, 0)
		$FadeOut.start()
		$PlayTime.stop()
		
func _on_PlayTime_timeout():
	fade('out')

func _on_FadeOut_tween_completed(object, key):
	object.stop()
	switch_song()
	fade('in')
