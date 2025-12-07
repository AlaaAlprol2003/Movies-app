import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/resources/routes_manager.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/profile_tab/presentation/cubit/profile_cubit.dart';
import 'package:movies_app/features/movies/presentation/main_layout/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'main_layout_provider.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainLayoutProvider>(context);
    return BlocListener<ProfileCubit,ProfileState>(
      listener: ( context,  state) {  
        if(state is UserDeleted){
          Navigator.of(context).pushNamedAndRemoveUntil(
          RoutesManager.login,
          (route) => false,
        );
        }
      },
      child: Scaffold(
        extendBody: true,
        body: provider.tabs[provider.selectedTab],
        bottomNavigationBar: CustomBottomNav(
          currentIndex: provider.selectedTab,
          onTap: provider.changeTab,
        )
      ),
    );
  }
}
