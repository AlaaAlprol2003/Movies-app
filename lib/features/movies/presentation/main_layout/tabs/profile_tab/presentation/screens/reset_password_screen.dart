import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/resources/ui_utils.dart';
import 'package:movies_app/core/widgets/custom_app_bar.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';

import '../../../../../../../auth/data/models/Reset_password_request.dart';
import '../cubit/reset_password_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }
  bool oldPassword = true;
  bool newPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "Reset Password"),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Image.asset(ImagesAssets.forgetPassword),
                SizedBox(height: 24.h),
                CustomTextFormField(
                  controller: oldPasswordController,
                  isObscure: oldPassword,
                  hintText: "old Password",
                  preIcon: ImageIcon(AssetImage(IconAssets.password)),
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 24.h),
                CustomTextFormField(
                  controller: newPasswordController,
                  isObscure: newPassword,
                  hintText: "new Password",
                  preIcon: ImageIcon(AssetImage(IconAssets.password)),
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 24.h),
            BlocListener<ResetPasswordCubit, ResetPasswordState>(
              listener: (context, state) {
                if (state is ResetPasswordLoading) {
                  UiUtils.showLoadingDialog(context);
                } else {
                  UiUtils.hideLoadingDialog(context);
                }
                if (state is ResetPasswordError) {
                  UiUtils.showToastNotificationBar(
                    context,
                    state.message,
                    ColorsManager.white,
                    ColorsManager.red,
                    Icons.error,
                  );
                }
                if (state is ResetPasswordSuccess) {
                  UiUtils.showToastNotificationBar(
                    context,
                    "Password changed successfully",
                    ColorsManager.white,
                    ColorsManager.green,
                    Icons.check,
                  );
                  Navigator.pop(context);
                }
              },
              child: Column(
                children: [
                  CustomElevatedButton(
                    text: "Change Password",
                    onPress: () {
                      if (formKey.currentState?.validate() == false) return;
                      context.read<ResetPasswordCubit>().resetPassword(
                        ResetPasswordRequest(
                          oldPassword: oldPasswordController.text,
                          newPassword: newPasswordController.text,
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
            ],
            ),
          ),
        ),
      ),
    );
  }
}
