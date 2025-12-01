import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/resources/colors_manager.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({
    super.key,
    required this.categoryName,
    required this.isSelected,
  });
  final String categoryName;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? ColorsManager.yellow : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorsManager.yellow),
      ),

      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
          child: Text(
            categoryName,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isSelected ? ColorsManager.black : ColorsManager.yellow,
            ),
          ),
        ),
      ),
    );
  }
}
