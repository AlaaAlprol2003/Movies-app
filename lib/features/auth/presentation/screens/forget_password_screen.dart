import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/value_manager.dart';
import 'package:movies_app/core/validators/app_validators.dart';
import 'package:movies_app/core/widgets/custom_app_bar.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "Forget Password"),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(ImagesAssets.forgetPassword),
              SizedBox(height: AppSize.s24.h),
              CustomTextFormField(
                controller: _emailController,
                validator: AppValidators.emailValidator,
                hintText: "Email",
                preIcon: ImageIcon(AssetImage(IconAssets.email)),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: AppSize.s24.h),
              CustomElevatedButton(text: "Verify Email", onPress: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
