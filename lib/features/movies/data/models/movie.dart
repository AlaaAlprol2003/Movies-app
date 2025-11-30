import '../../domain/entities/movie_summary_entity.dart';

class Movie {
  Movie({
      required this.id,
      required this.url,
      required this.title,
      required this.year,
      required this.rating,
      required this.runtime,
      required this.genres,
      required this.summary,
      required this.descriptionFull,
      required this.language,
      required this.backgroundImage,
      required this.smallCoverImage,
      required this.mediumCoverImage,
      required this.largeCoverImage,
      required this.state,
      required this.dateUploaded,
      });

 factory Movie.fromJson(dynamic json) {
   return Movie(
     id: json['id'],
     url: json['url'],
     title: json['title'],
     year: json['year'],
     rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : null,
     runtime: json['runtime'],
     genres: json['genres'] != null ? json['genres'].cast<String>() : [],
     summary: json['summary'],
     descriptionFull: json['description_full'],
     language: json['language'],
     backgroundImage: json['background_image'],
     smallCoverImage: json['small_cover_image'],
     mediumCoverImage: json['medium_cover_image'],
     largeCoverImage: json['large_cover_image'],
     state: json['state'],
     dateUploaded: json['date_uploaded'],

   );

  }
  final int? id;
  final String? url;
  final String? title;
  final int? year;
  final double? rating;
  final int? runtime;
  final List<String>? genres;
  final String? summary;
  final String? descriptionFull;
  final String? language;
  final String? backgroundImage;
  final String? smallCoverImage;
  final String? mediumCoverImage;
  final String? largeCoverImage;
  final String? state;
  final String? dateUploaded;

  MovieSummaryEntity toMovieSummaryEntity(){
    return MovieSummaryEntity(
      id: id,
      rating: rating,
      genres: genres,
      mediumCoverImage: mediumCoverImage,
    );
  }


}