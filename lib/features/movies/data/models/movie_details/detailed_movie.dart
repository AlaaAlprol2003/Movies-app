import 'package:movies_app/features/movies/data/models/movie_details/Cast.dart';

import '../../../domain/entities/movie_detials_entity.dart';

class DetailedMovie {
  const DetailedMovie({
    required this.id,
    required this.url,
    required this.title,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.likeCount,
    required this.descriptionFull,
    required this.backgroundImage,
    required this.mediumCoverImage,
    required this.mediumScreenshotImage1,
    required this.mediumScreenshotImage2,
    required this.mediumScreenshotImage3,
    required this.cast,
  });

  factory DetailedMovie.fromJson(dynamic json) {
    return DetailedMovie(
      id: json['id']??0,
      url: json['url']??'',
      title: json['title']??'',
      year: json['year']??0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      runtime: json['runtime']??0,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList()
          ?? [],
      likeCount: json['like_count']??0,
      descriptionFull: json['description_full']??'',
      backgroundImage: json['background_image']??'',
      mediumCoverImage: json['medium_cover_image']??'',
      mediumScreenshotImage1: json['medium_screenshot_image1']??'',
      mediumScreenshotImage2: json['medium_screenshot_image2']??'',
      mediumScreenshotImage3: json['medium_screenshot_image3']??'',
      cast:
          (json['cast'] as List<dynamic>?)
              ?.map((i) => Cast.fromJson(i))
              .toList() ??
          [],
    );
  }

  final int id;
  final String url;
  final String title;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final int likeCount;
  final String descriptionFull;
  final String backgroundImage;
  final String mediumCoverImage;
  final String mediumScreenshotImage1;
  final String mediumScreenshotImage2;
  final String mediumScreenshotImage3;
  final List<Cast> cast;

  MovieDetailsEntity toMovieDetailsEntity() {
    return MovieDetailsEntity(
      id: id,
      url: url,
      title: title,
      year: year,
      rating: rating,
      runtime: runtime,
      genres: genres,
      likeCount: likeCount,
      descriptionFull: descriptionFull,
      mediumCoverImage: mediumCoverImage,
      mediumScreenshotImage1: mediumScreenshotImage1,
      mediumScreenshotImage2: mediumScreenshotImage2,
      mediumScreenshotImage3: mediumScreenshotImage3,
      cast: cast,
    );
  }
}
