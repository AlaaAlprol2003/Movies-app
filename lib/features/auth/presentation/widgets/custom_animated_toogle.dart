import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class CustomAnimatedToggle extends StatelessWidget {
  const CustomAnimatedToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return AnimatedToggleSwitch<int>.rolling(
          current: provider.currentValue,
          values: [0, 1],
          onChanged: (i) {
            provider.switcher(i);
          },
          loading: false,
          style: ToggleStyle(
            backgroundColor: ColorsManager.black,
            borderColor: ColorsManager.yellow,
          ),
          iconList: [
            Image.asset(IconAssets.egypt),
            Image.asset(IconAssets.usa),
          ],
          indicatorIconScale: 1.5,
        );
      },
    );
  }
}
