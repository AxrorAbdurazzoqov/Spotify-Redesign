class SongModel {
  final String? uid;
  final String author;
  final String title;
  final String cover;
  final String song;

  SongModel({
    required this.uid,
    required this.author,
    required this.title,
    required this.cover,
    required this.song,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
        uid: json['uid'],
        author: json['author'],
        title: json['title'],
        cover: json['cover'],
        song: json['song'],
      );

  Map<String, dynamic> toJson() => {
        author: 'author',
        title: 'title',
        cover: 'cover',
        song: 'song'
      };
}
