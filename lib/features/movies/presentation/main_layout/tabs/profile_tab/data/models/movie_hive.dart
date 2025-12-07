import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'movie_hive.g.dart';

@HiveType(typeId: 1)
class MovieHive extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String photo;

  @HiveField(2)
  final double rating;

  MovieHive({required this.id, required this.photo, required this.rating});
}
