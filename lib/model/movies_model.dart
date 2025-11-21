class MovieModel {
  final int id;
  final String title;
  final double rating;
  final String? posterPath;
  final String overview;
  final String? releaseDate;
  final int? runtime;

  MovieModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.posterPath,
    required this.overview,
    this.releaseDate,
    this.runtime,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      rating: (json['vote_average'] ?? 0).toDouble(),
      posterPath: json['poster_path'],
      overview: json['overview'] ?? '',
      releaseDate: json['release_date'],

      runtime: null,
    );
  }

  String get posterFullUrl {
    if (posterPath == null) {
      return 'https://via.placeholder.com/300x450?text=No+Image';
    }
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  // Helper for year
  String get releaseYear {
    if (releaseDate != null && releaseDate!.isNotEmpty) {
      return releaseDate!.split('-')[0];
    }
    return 'N/A';
  }
}