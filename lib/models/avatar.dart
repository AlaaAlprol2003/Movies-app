import 'package:movies_app/core/resources/assets_manager.dart';

class Avatar {
  int id;
  String bath;

  Avatar({required this.id, required this.bath});

  static List<Avatar> avatars = [
    Avatar(id: 1, bath: ImagesAssets.avatar1),
    Avatar(id: 2, bath: ImagesAssets.avatar2),
    Avatar(id: 3, bath: ImagesAssets.avatar3),
    Avatar(id: 4, bath: ImagesAssets.avatar4),
    Avatar(id: 5, bath: ImagesAssets.avatar5),
    Avatar(id: 6, bath: ImagesAssets.avatar6),
    Avatar(id: 7, bath: ImagesAssets.avatar7),
    Avatar(id: 8, bath: ImagesAssets.avatar8),
    Avatar(id: 9, bath: ImagesAssets.avatar9),
  ];
}
