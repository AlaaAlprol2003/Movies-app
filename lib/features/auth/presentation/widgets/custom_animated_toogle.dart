import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../../config/lang_provider.dart';

class CustomAnimatedToggle extends StatelessWidget {
  const CustomAnimatedToggle({super.key});

  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LangProvider>(context);
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return AnimatedToggleSwitch<int>.rolling(
          current: provider.currentValue,
          values: [1, 0],
          onChanged: (i) {
            provider.switcher(i);
            langProvider.changeLang(i);
          },
          loading: false,
          style: ToggleStyle(
            backgroundColor: ColorsManager.black,
            borderColor: ColorsManager.yellow,
          ),
          iconList: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.yellow, width: 2.w),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Image.asset(IconAssets.usa),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.yellow, width: 2.w),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(IconAssets.egypt),
            ),
          ],
          indicatorIconScale: 1.5,
        );
      },
    );
  }
}
