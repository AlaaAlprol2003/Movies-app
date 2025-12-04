import '../../data/models/movie_details/Cast.dart';

class MovieDetailsEntity{
  MovieDetailsEntity({
    required this.id,
    required this.url,
    required this.title,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.likeCount,
    required this.descriptionFull,
    required this.mediumCoverImage,
    required this.mediumScreenshotImage1,
    required this.mediumScreenshotImage2,
    required this.mediumScreenshotImage3,
    required this.cast,
});
  final int id;
  final String url;
  final String title;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final int likeCount;
  final String descriptionFull;
  final String mediumCoverImage;
  final String mediumScreenshotImage1;
  final String mediumScreenshotImage2;
  final String mediumScreenshotImage3;
  final List<Cast>? cast;
}