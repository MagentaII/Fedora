class Music {
  final String musicId;
  final String musicName;
  final String artistName;
  final String musicImage;
  final String musicPath;

  Music({
    this.musicId = '-1',
    this.musicName = 'Unknown Title',
    this.artistName = 'Unknown Artist',
    this.musicImage = 'assets/images/default_album_art.jpg',
    this.musicPath = '',
  });

  factory Music.fromJson(Map<String, dynamic> map) {
    return Music(
      musicId: map['musicId'] as String,
      musicName: map['musicName'] as String,
      artistName: map['artistName'] as String,
      musicImage: map['musicImage'] as String,
      musicPath: map['musicPath'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "musicId": musicId,
      'musicName': musicName,
      'artistName': artistName,
      'musicImage': musicImage,
      'musicPath': musicPath,
    };
  }

  static Music empty() {
    return Music(
      musicId: '-1',
      musicName: 'Unknown Title',
      artistName: 'Unknown Artist',
      musicImage: 'assets/images/default_album_art.jpg',
      musicPath: '',
    );
  }

}
