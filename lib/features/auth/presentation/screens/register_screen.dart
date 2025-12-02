import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/resources/routes_manager.dart';
import 'package:movies_app/core/resources/ui_utils.dart';
import 'package:movies_app/core/validators/app_validators.dart';
import 'package:movies_app/core/widgets/custom_app_bar.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/core/widgets/custom_text_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/features/auth/data/models/register_request.dart';
import 'package:movies_app/features/auth/presentation/cubit/auth_cubit.dart';
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
                padding: REdgeInsets.only(left: 12.0, right: 12,top: 16,bottom: 32),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200.h,
                      child: CarouselSlider(
                        items: Avatar.avatars.map((avatar) {
                          return Image.asset(avatar.bath, fit: BoxFit.cover);
                        }).toList(),
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            provider.pickAvatarImage(index);
                          },
                          enlargeCenterPage: true,
                          enlargeFactor: 0.55,
                          viewportFraction: 0.55,
                        ),
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
                              ? Icons.visibility_off_rounded
                              : Icons.visibility,
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
                              ? Icons.visibility_off_rounded
                              : Icons.visibility,
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
                    BlocListener<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is RegisterLoading) {
                          UiUtils.showLoadingDialog(context);
                        } else if (state is RegisterError) {
                          UiUtils.hideLoadingDialog(context);
                          UiUtils.showToastificationBar(
                            context,
                            state.message,
                            ColorsManager.white,
                            ColorsManager.red,
                            Icons.error,
                          );
                        } else if (state is RegisterSuccess) {
                          UiUtils.hideLoadingDialog(context);
                          UiUtils.showToastificationBar(
                            context,
                            "Successfull Registeration ",
                            ColorsManager.white,
                            ColorsManager.green,
                            Icons.check_circle,
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesManager.login,
                          );
                        }
                      },
                      child: CustomElevatedButton(
                        text: "Create Account",
                        onPress: () {
                          if (provider.formKey.currentState?.validate() == false) return;
                          BlocProvider.of<AuthCubit>(context).register(
                            RegisterRequest(
                              name: provider.nameController.text,
                              email: provider.emailController.text,
                              password: provider.passwordController.text,
                              confirmPassword:
                                  provider.confirmPasswordController.text,
                              phone: provider.phoneController.text,
                              avaterId: provider.selectedAvatar,
                            ),
                          );
                        },
                      ),
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
                    SizedBox(width: 120.w, child: CustomAnimatedToggle()),
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
