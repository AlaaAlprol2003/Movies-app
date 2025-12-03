import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/resources/routes_manager.dart';
import 'package:movies_app/core/resources/ui_utils.dart';
import 'package:movies_app/core/validators/app_validators.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/core/widgets/custom_text_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/features/auth/data/models/login_request.dart';
import 'package:movies_app/features/auth/presentation/cubit/auth_cubit.dart';
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
              child: Form(
                key: provider.formKey,
                child: Column(
                  children: [
                    Image.asset(ImagesAssets.logo),
                    SizedBox(height: 65.h),
                    CustomTextFormField(
                      controller: provider.loginEmailController,
                      validator: AppValidators.emailValidator,
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      preIcon: ImageIcon(AssetImage(IconAssets.email)),
                    ),
                    SizedBox(height: 24.h),
                    CustomTextFormField(
                      controller: provider.loginPasswordController,
                      validator: AppValidators.passwordValidator,
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
                    SizedBox(height: 18.h),
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
                    BlocListener<AuthCubit, AuthState>(
                      listenWhen: (prev, curr) =>
                          prev.runtimeType != curr.runtimeType,
                      listener: (context, state) {
                        if (state is LoginLoading) {
                          UiUtils.showLoadingDialog(context);
                        } else if (state is LoginError) {
                          UiUtils.hideLoadingDialog(context);
                          UiUtils.showToastificationBar(
                            context,
                            state.message,
                            ColorsManager.white,
                            ColorsManager.green,
                            Icons.error,
                          );
                        } else if (state is LoginSuccess) {
                          UiUtils.hideLoadingDialog(context);
                          UiUtils.showToastificationBar(
                            context,
                            "Logged-in Successfully",
                            ColorsManager.white,
                            ColorsManager.green,
                            Icons.check_circle,
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesManager.mainLayout,
                          );
                        }
                      },
                      child: CustomElevatedButton(
                        text: "Login",
                        onPress: () {
                          if (provider.formKey.currentState?.validate() ==
                              false)
                            return;
                          BlocProvider.of<AuthCubit>(context).login(
                            LoginRequest(
                              email: provider.loginEmailController.text,
                              password: provider.loginPasswordController.text,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 22.h),
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
                            Navigator.pushNamed(
                              context,
                              RoutesManager.register,
                            );
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
                            endIndent: 12.w,
                            indent: 90.w,
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
                            endIndent: 90.w,
                            indent: 12.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28.h),
                    CustomElevatedButton(
                      text: "Login With Google",
                      onPress: () {
                        provider.logInWithGoogle(context);
                      },
                      icon: ImageIcon(AssetImage(IconAssets.google)),
                    ),
                    SizedBox(height: 24.h),

                    SizedBox(width: 120.w, child: CustomAnimatedToggle()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
