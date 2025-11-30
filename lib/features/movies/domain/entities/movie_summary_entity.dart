class MovieSummaryEntity{
  MovieSummaryEntity({
    required this.id,
    required this.rating,
    required this.mediumCoverImage,
    required this.genres,
  });
  final int? id;
  final double? rating;
  final String? mediumCoverImage;
  final List<String>? genres;
}