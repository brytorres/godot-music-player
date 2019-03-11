# Godot Music Player
A simple background music system for Godot.

## Setup
Included in this repo are 5 audio files for testing, the scenes needed, and a script. The current system is very basic and could use some extra features which will be listed further below. It's intended for a game that can utilize a playlist type of system that continuously plays versus a song for a specific scene.

The Audio scene should be included in your main game scene so that it plays throughout the entire game. Heres a layout of the scene structure:
```
Game
└───Audio (Node)
│   └───Music (Node) [Music.gd]
│       │   MusicPlayer (AudioStreamPlayer)
│       │   FadeOut (Tween)
│       │   FadeIn (Tween)
│       │   PlayTime (Timer)
```

The assets can be placed anywhere in your project. For example, this is the project structure I use:
```
res://
└───assets
│   └───audio
│       └───music
│           │   beepage.wav
│           │   dance_of_the_satellites.wav
│           │   digital_sunset.wav
│           │   high_tech_city.wav
│           │   ocean_technology.wav
└───scenes
│   └───audio
│       └───music
│       │   │   Music.tscn
│       │   Audio.tscn
└───scripts
│   └───audio
│       └───music
│           │   Music.gd
```

## How To Use
By attaching the `Music.gd` script is attached to the Music scene, you will have access to four exported variables which handle song play time, fade time, max volume, and the transition type. Transition type is a parameter for a Tweens `interpolate_property` method.  
```
export var fade_time = 10
export var play_time = 30
export var max_volume = -15
export var transition_type = 0 # Linear 
```

You must make sure that the songs and in an assets folder and that the correct path is setup in the scripts `set_audio_stream()` method.
```
func set_audio_stream(song):
	audiostream = load('res://assets/audio/music/' + songs[song] + '.wav')
	get_node("MusicPlayer").set_stream(audiostream)
```

Lastly, the strings in the `songs` array handle which songs get loaded. The order of the file names will reflect the order in which the songs will play in. By default it is set to:
```
var songs = [
	'beepage',
	'dance_of_the_satellites',
	'digital_sunset',
	'high_tech_city',
	'ocean_technology'
]
```

Currently the music is setup to start whenever the Audio scene is instanced on `_ready()`. To stop the music, you can call `$Audio/Music/MusicPlayer.stop()` from the main Game scene that contains the `Audio` scene.

## Features to Add
* Better Start/Stop methods
* Better volume handling (connect to UI)
* Dynamically build the songs list from the contents of the folder
* Create playlists by mood/environment, and a way to trigger the playlist based on a mood/scene change.

## Credits
The included assets are royalty free music from [Soundimage.org](https://soundimage.org/techno/) by Eric Matyas.