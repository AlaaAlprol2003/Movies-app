import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/resources/routes_manager.dart';
import 'package:movies_app/core/resources/value_manager.dart';
import 'package:movies_app/core/validators/app_validators.dart';
import 'package:movies_app/core/widgets/custom_app_bar.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/core/widgets/custom_text_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:movies_app/features/auth/presentation/widgets/custom_animated_toogle.dart';
import 'package:movies_app/models/avatar.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.black,
      appBar: CustomAppBar(titleText: "Register",onIconPress: (){
        Navigator.pop(context);
      },),
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
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(width: AppSize.s2),
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),

                              child: Image.asset(
                                Avatar.avatars[index].bath,
                                fit: isSelected ? BoxFit.cover : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: AppSize.s24.h),
                    Text(
                      "Avatar",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: AppSize.s24.h),
                    CustomTextFormField(
                      validator: AppValidators.nameValidator,
                      controller: provider.nameController,

                      hintText: "Name",
                      preIcon: ImageIcon(AssetImage(IconAssets.name)),
                    ),
                    SizedBox(height: AppSize.s24.h),
                    CustomTextFormField(
                      validator: AppValidators.emailValidator,
                      controller: provider.emailController,
                      hintText: "Email",
                      preIcon: ImageIcon(AssetImage(IconAssets.email)),
                    ),
                    SizedBox(height: AppSize.s24.h),
                    CustomTextFormField(
                      validator: AppValidators.passwordValidator,
                      controller: provider.passwordController,
                      isObscure: provider.visiblePassword,
                      hintText: "Password",
                      preIcon: ImageIcon(AssetImage(IconAssets.password)),
                      suffIcon: IconButton(
                        onPressed: provider.changePasswordVisibilityState,
                        icon: Icon(
                          provider.visiblePassword
                              ? Icons.visibility
                              : Icons.visibility_off_rounded,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSize.s24.h),
                    CustomTextFormField(
                      validator: provider.confirmPasswordValidator,
                      controller: provider.confirmPasswordController,
                      isObscure: provider.visibleConfirmPassword,
                      hintText: "Confirm Password",
                      preIcon: ImageIcon(AssetImage(IconAssets.password)),
                      suffIcon: IconButton(
                        onPressed:
                            provider.changeConfirmPasswordVisibilityState,
                        icon: Icon(
                          provider.visibleConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off_rounded,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSize.s24.h),
                    CustomTextFormField(
                      validator: AppValidators.phoneValidator,
                      controller: provider.phoneController,
                      hintText: "Phone Number",
                      preIcon: ImageIcon(AssetImage(IconAssets.phone)),
                    ),
                    SizedBox(height: AppSize.s24.h),
                    CustomElevatedButton(
                      text: "Create Account",
                      onPress: () {
                        provider.onCreateAccountClicked();
                      },
                    ),
                    SizedBox(height: AppSize.s18.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already Have Account ?",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),

                        CustomTextButton(text: "Login", onPress: () {
                          Navigator.pushReplacementNamed(context, RoutesManager.login);
                        }),
                      ],
                    ),
                    SizedBox(height: AppSize.s18.h),
                    CustomAnimatedToggle(),
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
