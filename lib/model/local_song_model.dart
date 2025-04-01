class LocalSongModel {
  final int id;
  final String title;
  final String artist;
  final String uri;
  final String albumArt;
  final int duration;

  LocalSongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.uri,
    required this.albumArt,
    required this.duration,
  });
}
