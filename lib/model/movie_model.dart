class MovieModel {
  final int? id;
  final String title;
  final String poster;
  final String releaseData;
  final double rating;
  final int likes;
  final int views;
  final String? trailerCode;
  final String screenshot1;
  final String screenshot2;
  final String screenshot3;
  MovieModel({
    required this.title,
    required this.poster,
    required this.releaseData,
    required this.rating,
    required this.likes,
    required this.views,
    required this.screenshot1,
    required this.screenshot2,
    required this.screenshot3,
    this.id,
    this.trailerCode,
  });
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "poster": poster,
      "releaseData": releaseData,
      "rating": rating,
      "likes": likes,
      "views": views,
    };
  }

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"],
      title: json["title"] ?? "No Title",
      poster: json["medium_cover_image"] ?? "",
      releaseData: json["year"] != null ? json["year"].toString() : "Unknown",
      rating: json["rating"] != null ? (json["rating"] as num).toDouble() : 0.0,
      likes: json["like_count"] != null ? json["like_count"] as int : 0,
      views: json["download_count"] != null ? json["download_count"] as int : 0,
      trailerCode: json["yt_trailer_code"] ?? '',
      screenshot1: json['medium_screenshot_image1'] ?? '',
      screenshot2: json['medium_screenshot_image2'] ?? '',
      screenshot3: json['medium_screenshot_image3'] ?? '',
    );
  }
}
