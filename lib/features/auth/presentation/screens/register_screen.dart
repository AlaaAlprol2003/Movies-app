import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/resources/routes_manager.dart';
import 'package:movies_app/core/validators/app_validators.dart';
import 'package:movies_app/core/widgets/custom_app_bar.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/core/widgets/custom_text_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:movies_app/features/auth/presentation/widgets/custom_animated_toogle.dart';
import 'package:provider/provider.dart';

import '../../../../core/models/avatar.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.black,
      appBar: CustomAppBar(titleText: "Register"),
      body: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Form(
              key: provider.formKey,
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Avatar.avatars.length,
                        itemBuilder: (context, index) {
                          bool isSelected =
                              provider.selectedAvatar ==
                              Avatar.avatars[index].id;
                          return GestureDetector(
                            onTap: () {
                              provider.pickAvatarImage(
                                Avatar.avatars[index].id,
                              );
                            },
                            child: Image.asset(
                              Avatar.avatars[index].bath,
                              fit: isSelected ? BoxFit.cover : null,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "Avatar",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 24.h),
                    CustomTextFormField(
                      validator: AppValidators.nameValidator,
                      controller: provider.nameController,
                      hintText: "Name",
                      preIcon: ImageIcon(AssetImage(IconAssets.name)),
                    ),
                    SizedBox(height: 24.h),
                    CustomTextFormField(
                      validator: AppValidators.emailValidator,
                      controller: provider.emailController,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      preIcon: ImageIcon(AssetImage(IconAssets.email)),
                    ),
                    SizedBox(height: 24.h),
                    CustomTextFormField(
                      validator: AppValidators.passwordValidator,
                      controller: provider.passwordController,
                      isObscure: provider.visiblePassword,
                      hintText: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      preIcon: ImageIcon(AssetImage(IconAssets.password)),
                      sufIcon: IconButton(
                        onPressed: provider.changePasswordVisibilityState,
                        icon: Icon(
                          provider.visiblePassword
                              ? Icons.visibility
                              : Icons.visibility_off_rounded,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CustomTextFormField(
                      validator: provider.confirmPasswordValidator,
                      controller: provider.confirmPasswordController,
                      isObscure: provider.visibleConfirmPassword,
                      hintText: "Confirm Password",
                      keyboardType: TextInputType.visiblePassword,
                      preIcon: ImageIcon(AssetImage(IconAssets.password)),
                      sufIcon: IconButton(
                        onPressed:
                            provider.changeConfirmPasswordVisibilityState,
                        icon: Icon(
                          provider.visibleConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off_rounded,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CustomTextFormField(
                      validator: AppValidators.phoneValidator,
                      controller: provider.phoneController,
                      hintText: "Phone Number",
                      keyboardType: TextInputType.phone,
                      preIcon: ImageIcon(AssetImage(IconAssets.phone)),
                    ),
                    SizedBox(height: 24.h),
                    CustomElevatedButton(
                      text: "Create Account",
                      onPress: () {
                        provider.onCreateAccountClicked();
                      },
                    ),
                    SizedBox(height: 18.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have Account ?",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),

                        CustomTextButton(
                          text: "Login",
                          onPress: () {
                            Navigator.pushReplacementNamed(
                              context,
                              RoutesManager.login,
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    SizedBox(
                      width: 120.w,
                      child: CustomAnimatedToggle(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
