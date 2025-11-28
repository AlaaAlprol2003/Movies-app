import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/resources/routes_manager.dart';
import 'package:movies_app/core/resources/value_manager.dart';
import 'package:movies_app/core/validators/app_validators.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/core/widgets/custom_text_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:movies_app/features/auth/presentation/widgets/custom_animated_toogle.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.black,
      body: Padding(
        padding: REdgeInsets.only(top: 67.0, left: 12, right: 12),
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(ImagesAssets.logo),
                  SizedBox(height: AppSize.s65.h),
                  CustomTextFormField(
                    controller: provider.emailController,
                    validator: AppValidators.emailValidator,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    preIcon: ImageIcon(AssetImage(IconAssets.email)),
                  ),
                  SizedBox(height: AppSize.s24.h),
                  CustomTextFormField(
                    controller: provider.passwordController,
                    validator: AppValidators.passwordValidator,
                    isObscure: provider.visiblePassword,
                    hintText: "Password",
                    keyboardType: TextInputType.visiblePassword,
                    preIcon:ImageIcon(AssetImage(IconAssets.password)),
                    suffIcon: IconButton(
                      onPressed: provider.changePasswordVisibilityState,
                      icon: Icon(
                        provider.visiblePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.s18.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CustomTextButton(
                      text: "Forget Password?",
                      onPress: () {
                        Navigator.pushNamed(
                          context,
                          RoutesManager.forgetPassword,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 35.h),
                  CustomElevatedButton(text: "Login", onPress: () {}),
                  SizedBox(height: AppSize.s22.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have Account? ",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      CustomTextButton(
                        text: "Create One",
                        onPress: () {
                          Navigator.pushNamed(context, RoutesManager.register);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: ColorsManager.yellow,
                          thickness: 1,
                          endIndent: AppSize.s12.w,
                          indent: AppSize.s90.w,
                        ),
                      ),
                      Text(
                        "Or",
                        style: Theme.of(context).textTheme.headlineSmall!
                            .copyWith(color: ColorsManager.yellow),
                      ),
                      Expanded(
                        child: Divider(
                          color: ColorsManager.yellow,
                          thickness: 1,
                          endIndent: AppSize.s90.w,
                          indent: AppSize.s12.w,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.s28.h),
                  CustomElevatedButton(
                    text: "Login With Google",
                    onPress: () {},
                    icon: ImageIcon(AssetImage(IconAssets.google)),
                  ),
                  SizedBox(height: AppSize.s24.h),

                  SizedBox(
                    width: AppSize.s120.w,
                    child: CustomAnimatedToggle()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
