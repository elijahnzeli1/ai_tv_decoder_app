class Channel {
  final String id;
  final String name;
  final String? category;
  final String? logoUrl;
  final String? streamUrl;
  bool isFavorite;
  double frequency;
  String? region;

  Channel({
    required this.id,
    required this.name,
    this.category,
    this.logoUrl,
    this.streamUrl,
    this.isFavorite = false,
    this.frequency = 0.0,
    this.region,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'].toString(),
      name: json['name'],
      category: json['category'],
      logoUrl: json['logo_url'],
      streamUrl: json['stream_url'],
      isFavorite: json['is_favorite'] ?? false,
      frequency: json['frequency'] ?? 0.0,
      region: json['region'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'logo_url': logoUrl,
      'stream_url': streamUrl,
      'is_favorite': isFavorite,
      'frequency': frequency,
      'region': region,
    };
  }

  static fromTVMazeJson(json) {}
}
