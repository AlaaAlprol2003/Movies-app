import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/widgets/movie_item.dart';
import 'package:movies_app/features/movies/domain/entities/movie_summary_entity.dart';
import 'package:movies_app/features/movies/presentation/main_layout/tabs/search_tab/cubit/search_cubit.dart';
import 'package:provider/provider.dart';
import '../../main_layout_provider.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainLayoutProvider>(context);

    return SafeArea(
      child: Padding(
        padding: REdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: Column(
          children: [
            TextField(
              cursorColor: ColorsManager.white,
              onChanged: (input) {
                provider.onSearchChange(input, context);
              },
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: ColorsManager.white,
              ),
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Image.asset(IconAssets.search1),
              ),
            ),
            SizedBox(height: 16.h),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (provider.searchKey.isEmpty) {
                  return Expanded(
                    child: Center(child: Image.asset(ImagesAssets.empity)),
                  );
                }
                if (state is SearchLoading) {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator(color: ColorsManager.yellow)),
                  );
                } else if (state is SearchError) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: ColorsManager.red),
                      ),
                    ),
                  );
                } else if (state is SearchSuccess) {
                  if(state.movies.isEmpty){
                    return Expanded(child:Center(child: Text("No Movies Found",style: TextStyle(color: ColorsManager.yellow))) ,);
                  }
                  return Expanded(
                    child: GridView.builder(
                      itemCount: state.movies.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.h,
                        crossAxisSpacing: 12.w,
                        childAspectRatio: 7 / 10,
                      ),
                      itemBuilder: (context, index) {
                        List<MovieSummaryEntity> movies = state.movies;
                        return MovieItem(
                         movie: movies[index],
                        );
                      },
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
