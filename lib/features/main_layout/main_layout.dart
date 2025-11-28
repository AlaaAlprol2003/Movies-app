import 'package:flutter/material.dart';
import 'package:movies_app/features/main_layout/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'main_layout_provider.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainLayoutProvider>(context);
    return Scaffold(
      extendBody: true,
      body: provider.tabs[provider.selectedTab],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: provider.selectedTab,
        onTap: provider.changeTab,
      )
    );
  }
}
