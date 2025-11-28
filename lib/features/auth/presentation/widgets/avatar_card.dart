import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/models/avatar.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({super.key, required this.avatar});
  final Avatar avatar ;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60),
        side: BorderSide(color: ColorsManager.yellow)
      ),
      child: Image.asset(avatar.bath,),
    );
  }
}