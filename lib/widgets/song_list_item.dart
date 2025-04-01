import 'package:flutter/material.dart';

import '../model/local_song_model.dart';
import '../screen/player_screen.dart';
import '../service/audio_controller.dart';

class SongListItem extends StatelessWidget {
  final LocalSongModel song;
  final int index;

  const SongListItem({
    super.key,
    required this.song,
    required this.index,
  });

  String _formatDuration(int milliseconds) {
    final minutes = (milliseconds / 60000).floor();
    final seconds = ((milliseconds % 60000) / 1000).floor();
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final audioController = AudioController();

    return ValueListenableBuilder(
      valueListenable: audioController.currentIndex,
      builder: (context, currentIndex, child) {
        return ValueListenableBuilder(
          valueListenable: audioController.isPlaying,
          builder: (context, isPlaying, child) {
            final isCurrentSong = currentIndex == index;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.music_note,
                    color: Colors.white54,
                  ),
                ),
                title: Text(
                  song.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  song.artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatDuration(song.duration),
                     ),
                    const SizedBox(width: 8),
                    Icon(
                      isCurrentSong && isPlaying
                          ? Icons.pause_circle
                          : Icons.play_circle,
                      color: isCurrentSong && isPlaying
                          ? Colors.greenAccent
                          : Colors.white54,
                    ),
                  ],
                ),
                onTap: () {
                  audioController.playSong(index);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerScreen(
                        song: song,
                        index: index,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
