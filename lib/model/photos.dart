

class Photos {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  const Photos({required this.albumId, required this.id, required this.title, required this.url, required this.thumbnailUrl});

  factory Photos.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'albumId': int albumId, 'id': int id, 'title': String title, 'url': String url, 'thumbnailUrl': String thumbnailUrl} => Photos(
        albumId: albumId,
        id: id,
        title: title,
        url: url,
        thumbnailUrl: thumbnailUrl
      ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['albumId'] = albumId;
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['thumbnailUrl'] = thumbnailUrl;
    return data;
  }

}