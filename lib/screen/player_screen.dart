import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:tunesync/service/audio_controller.dart';

import '../model/local_song_model.dart';
import '../widgets/neo_button.dart';
import '../widgets/neo_container.dart';

class PlayerScreen extends StatefulWidget {
  final LocalSongModel song;
  final int index;
   PlayerScreen({super.key , required this.index , required this.song});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final audioController = AudioController();
  bool _isPlaying = false;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ValueListenableBuilder(valueListenable: audioController.currentIndex, builder: (context , currentIndex , _){
              return Column(
                children: [
                  // Header with back button
                  Row(
                    children: [
                      NeoButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                      ),
                      const Spacer(),
                      Text(
                        'Now Playing',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4A5668),
                        ),
                      ),
                      const Spacer(),
                      NeoButton(
                        onPressed: () {},
                        child: const Icon(Icons.more_vert, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // Album Art
                  NeoContainer(
                    width: size.width * 0.7,
                    height: size.width * 0.7,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1496293455970-f8581aae0e3b?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.music_note, size: 60),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  /// --- SONG TITLE --- ///
                  SizedBox(
                    height: 30,
                    child: Marquee(
                      blankSpace: 50,
                      startPadding: 10,
                      velocity: 30,
                      style: const TextStyle(
                        fontSize: 25,
                          color: Color(0xFF4A5668)
                      ),
                      text: widget.song.title.toString().split('/').last,
                    ),
                  ),
                  Text(
                    widget.song.artist,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Song Info



                  const SizedBox(height: 30),

                  /// --- Progress Bar --- ///
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: StreamBuilder<Duration>(
                      stream: audioController.audioPlayer.positionStream,
                      builder: (context, snapshot) {
                        final position = snapshot.data ?? Duration.zero;
                        final duration = audioController.audioPlayer.duration ?? Duration.zero;
                        return ProgressBar(
                          progress: position,
                          total: duration,
                          progressBarColor: Colors.greenAccent,
                          baseBarColor: Colors.black26,
                          bufferedBarColor: Colors.black12,
                          thumbColor: Colors.greenAccent,
                          onSeek: (duration) {
                            audioController.audioPlayer.seek(duration);
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Main Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NeoButton(
                        onPressed: () {
                          audioController.previousSong();
                        },
                        child: const Icon(Icons.skip_previous_rounded, size: 30),
                      ),
                      NeoButton(
                        btnBackGroundColor: Colors.greenAccent,
                        onPressed: () {
                          audioController.togglePlayPause();

                          setState(() {
                            _isPlaying = !_isPlaying;
                          });
                        },
                        padding: const EdgeInsets.all(20),
                        isPressed: _isPlaying,
                        child: Icon(
                          _isPlaying ? Icons.play_arrow_rounded : Icons.pause_rounded,
                          size: 40,
                        ),
                      ),
                      NeoButton(
                        onPressed: () {
                          audioController.nextSong();

                        },
                        child: const Icon(Icons.skip_next_rounded, size: 30),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),



                ],
              );
            })
          ),
        ),
      ),
    );
  }
}



