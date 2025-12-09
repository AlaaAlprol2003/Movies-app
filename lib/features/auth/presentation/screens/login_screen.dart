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
import '../../../../l10n/app_localizations.dart';
import '../cubit/auth_cubit_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  late AuthProvider provider;

  @override
  void didChangeDependencies() {
   provider= Provider.of<AuthProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    provider.loginEmailController.clear();
    provider.loginPasswordController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorsManager.black,
      body: Padding(
        padding: REdgeInsets.only(top: 67.0, left: 12, right: 12),
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return SingleChildScrollView(
              child: Form(
                key: provider.loginFormKey,
                child: Column(
                  children: [
                    Image.asset(ImagesAssets.logo),
                    SizedBox(height: 65.h),
                    CustomTextFormField(
                      controller: provider.loginEmailController,
                      validator: AppValidators.emailValidator,
                      hintText: appLocalizations.email,
                      keyboardType: TextInputType.emailAddress,
                      preIcon: ImageIcon(AssetImage(IconAssets.email)),
                    ),
                    SizedBox(height: 24.h),
                    CustomTextFormField(
                      controller: provider.loginPasswordController,
                      validator: AppValidators.passwordValidator,
                      isObscure: provider.visiblePassword,
                      hintText: appLocalizations.password,
                      keyboardType: TextInputType.visiblePassword,
                      preIcon:ImageIcon(AssetImage(IconAssets.password)),
                      sufIcon: IconButton(
                        onPressed: provider.changePasswordVisibilityState,
                        icon: Icon(
                          provider.visiblePassword
                               ? Icons.visibility_off_rounded
                              : Icons.visibility
                        ),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(
                        text: appLocalizations.forget_password,
                        onPress: () {
                          Navigator.pushNamed(
                            context,
                            RoutesManager.forgetPassword,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 35.h),
                    BlocListener<AuthCubit,AuthState>(
                      listener: (context,state){
                        if(state is LoginLoading){
                          UiUtils.showLoadingDialog(context);
                        }else if(state is LoginError){
                          UiUtils.hideLoadingDialog(context);
                          UiUtils.showToastNotificationBar(context, state.message, ColorsManager.white, ColorsManager.red, Icons.error);
                        }else if(state is LoginSuccess){
                          UiUtils.hideLoadingDialog(context);
                          UiUtils.showToastNotificationBar(context, appLocalizations.logged_in_successfully, ColorsManager.white, ColorsManager.green, Icons.check_circle);
                          Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
                        }
                      },
                      child: CustomElevatedButton(text: appLocalizations.login, onPress: () {
                         if(provider.loginFormKey.currentState?.validate() == false) return ;
                         BlocProvider.of<AuthCubit>(context).login(LoginRequest(
                          email: provider.loginEmailController.text,
                          password: provider.loginPasswordController.text,
                         ));
                      })),
                    SizedBox(height: 22.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          appLocalizations.dont_have_account,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        CustomTextButton(
                          text: appLocalizations.create_one,
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
                            endIndent: 12.w,
                            indent: 90.w,
                          ),
                        ),
                        Text(
                          appLocalizations.or,
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
                      text: appLocalizations.login_with_google,
                      onPress: () {},
                      icon: ImageIcon(AssetImage(IconAssets.google)),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: 120.w,
                      child: CustomAnimatedToggle()),
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
