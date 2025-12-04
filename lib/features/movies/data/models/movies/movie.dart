import '../../../domain/entities/movie_summary_entity.dart';

class Movie {
  Movie({
      required this.id,
      required this.url,
      required this.title,
      required this.year,
      required this.rating,
      required this.backgroundImage,
      required this.mediumCoverImage,
      required this.state,
      });

  factory Movie.fromJson(dynamic json) {
    return Movie(
      id: json['id'] ?? 0,
      url: json['url'] ?? '',
      title: json['title'] ?? '',
      year: json['year'] ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      backgroundImage: json['background_image'] ?? '',
      mediumCoverImage: json['medium_cover_image'] ?? '',
      state: json['state'] ?? '',
    );
  }
  final int id;
  final String url;
  final String title;
  final int year;
  final double rating;
  final String backgroundImage;
  final String mediumCoverImage;
  final String state;

  MovieSummaryEntity toMovieSummaryEntity(){
    return MovieSummaryEntity(
      id: id,
      rating: rating,
      mediumCoverImage: mediumCoverImage,
    );
  }


}