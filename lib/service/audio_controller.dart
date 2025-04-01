import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../model/local_song_model.dart';


class AudioController {
  static final AudioController instance = AudioController._internal();
  factory AudioController() => instance;
  AudioController._internal() {
    _setupAudioPlayer();
  }

  final AudioPlayer audioPlayer = AudioPlayer();
  final OnAudioQuery audioQuery = OnAudioQuery();
  final ValueNotifier<List<LocalSongModel>> songs = ValueNotifier<List<LocalSongModel>>([]);
  final ValueNotifier<int> currentIndex = ValueNotifier<int>(-1);
  final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);

  LocalSongModel? get currentSong => 
      currentIndex.value != -1 && currentIndex.value < songs.value.length 
          ? songs.value[currentIndex.value] 
          : null;

  void _setupAudioPlayer() {
    // Listen to player state changes
    audioPlayer.playerStateStream.listen((playerState) {
      isPlaying.value = playerState.playing;
      
      // Auto play next song when current song ends
      if (playerState.processingState == ProcessingState.completed) {
        if (currentIndex.value < songs.value.length - 1) {
          playSong(currentIndex.value + 1);
        } else {
          // If it's the last song, stop playing
          currentIndex.value = -1;
          isPlaying.value = false;
        }
      }
    });

    // Listen to position changes
    audioPlayer.positionStream.listen((_) {
      // This helps update the UI for progress bars
      isPlaying.notifyListeners();
    });
  }

  Future<void> loadSongs() async {
    final fetchedSongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    
    songs.value = fetchedSongs.map((song) => LocalSongModel(
      id: song.id,
      title: song.title,
      artist: song.artist ?? 'Unknown Artist',
      uri: song.uri ?? '',
      albumArt: song.album ?? '',
      duration: song.duration ?? 0,
    )).toList();
  }

  Future<void> playSong(int index) async {
    if (index < 0 || index >= songs.value.length) return;
    
    try {
      if (currentIndex.value == index && isPlaying.value) {
        await pauseSong();
        return;
      }

      currentIndex.value = index;
      final song = songs.value[index];
      
      await audioPlayer.stop();
      await audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(song.uri)),
        preload: true, // Preload the next song
      );
      await audioPlayer.play();
      isPlaying.value = true;
    } catch (e) {
      debugPrint('Error playing song: $e');
    }
  }

  Future<void> pauseSong() async {
    await audioPlayer.pause();
    isPlaying.value = false;
  }

  Future<void> resumeSong() async {
    await audioPlayer.play();
    isPlaying.value = true;
  }

  void togglePlayPause() async {
    if (currentIndex.value == -1) return;
    
    try {
      if (isPlaying.value) {
        await pauseSong();
      } else {
        await resumeSong();
      }
    } catch (e) {
      debugPrint('Error toggling play/pause: $e');
    }
  }

  Future<void> nextSong() async {
    if (currentIndex.value < songs.value.length - 1) {
      await playSong(currentIndex.value + 1);
    }
  }

  Future<void> previousSong() async {
    if (currentIndex.value > 0) {
      await playSong(currentIndex.value - 1);
    }
  }

  void dispose() {
    audioPlayer.dispose();
  }
}
