/*
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import '../controllers/audio_controller.dart';
import '../screens/player_screen.dart';

class NowPlayingBar extends StatelessWidget {
  const NowPlayingBar({super.key});

  @override
  Widget build(BuildContext context) {
    final audioController = AudioController();

    return ValueListenableBuilder(
      valueListenable: audioController.currentIndex,
      builder: (context, currentIndex, _) {
        final currentSong = audioController.currentSong;
        if (currentSong == null) return const SizedBox.shrink();
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlayerScreen(
                  song: currentSong,
                  index: currentIndex,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StreamBuilder<Duration>(
                  stream: audioController.audioPlayer.positionStream,
                  builder: (context, snapshot) {
                    final position = snapshot.data ?? Duration.zero;
                    final duration = audioController.audioPlayer.duration ?? Duration.zero;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ProgressBar(
                        progress: position,
                        total: duration,
                        progressBarColor: Colors.greenAccent,
                        baseBarColor: Colors.white24,
                        bufferedBarColor: Colors.white10,
                        thumbColor: Colors.greenAccent,
                        barHeight: 3,
                        thumbRadius: 6,
                        timeLabelLocation: TimeLabelLocation.none,
                        onSeek: (duration) {
                          audioController.audioPlayer.seek(duration);
                        },
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.music_note,
                          color: Colors.white54,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentSong.title,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              currentSong.artist,
                              style: GoogleFonts.poppins(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.skip_previous),
                            color: Colors.white,
                            onPressed: audioController.previousSong,
                          ),
                          StreamBuilder<PlayerState>(
                            stream: audioController.audioPlayer.playerStateStream,
                            builder: (context, snapshot) {
                              final playerState = snapshot.data;
                              final processingState = playerState?.processingState;
                              final playing = playerState?.playing;

                              if (processingState == ProcessingState.loading ||
                                  processingState == ProcessingState.buffering) {
                                return Container(
                                  margin: const EdgeInsets.all(8.0),
                                  width: 32.0,
                                  height: 32.0,
                                  child: const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                                  ),
                                );
                              }

                              Icon icon;
                              if (playing == true) {
                                icon = const Icon(Icons.pause_circle_filled, size: 42);
                              } else {
                                icon = const Icon(Icons.play_circle_filled, size: 42);
                              }

                              return IconButton(
                                icon: icon,
                                color: Colors.greenAccent,
                                onPressed: audioController.togglePlayPause,
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.skip_next),
                            color: Colors.white,
                            onPressed: audioController.nextSong,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
*/
