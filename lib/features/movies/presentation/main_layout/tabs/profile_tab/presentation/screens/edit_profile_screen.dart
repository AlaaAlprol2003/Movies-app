import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/models/avatar.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/resources/routes_manager.dart';
import 'package:movies_app/core/resources/ui_utils.dart';
import 'package:movies_app/core/widgets/custom_elevated_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import '../cubit/profile_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentPhone;
  final int currentAvatar;

  final String email;

  const EditProfileScreen({
    super.key,
    required this.currentName,
    required this.currentPhone,
    required this.currentAvatar,
    required this.email,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late int _selectedAvatar;
  bool _showAvatarPicker = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _phoneController = TextEditingController(text: widget.currentPhone);
    _selectedAvatar = widget.currentAvatar;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is EditProfileLoading) {
          UiUtils.hideLoadingDialog(context);
        }

        if (state is EditProfileError) {
          UiUtils.hideLoadingDialog(context);
          UiUtils.showToastNotificationBar(
            context,
            state.message,
            ColorsManager.white,
            ColorsManager.red,
            Icons.error,
          );
        }

        if (state is EditProfileSuccess) {
          UiUtils.hideLoadingDialog(context);

          UiUtils.showToastNotificationBar(
            context,
            "Profile Updated Successfully",
            ColorsManager.white,
            ColorsManager.green,
            Icons.check_circle,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorsManager.black,
          appBar: AppBar(
            backgroundColor: ColorsManager.grey,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Edit Profile',
              style: TextStyle(
                color: ColorsManager.yellow,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  GestureDetector(
                    onTap: () {
                      setState(() => _showAvatarPicker = !_showAvatarPicker);
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60.r,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.asset(
                              Avatar.avatars[_selectedAvatar].bath,
                              width: 120.w,
                              height: 120.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: ColorsManager.yellow,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 3.w,
                              ),
                            ),
                            child: Icon(Icons.camera_alt, size: 20.sp),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  CustomTextFormField(
                    hintText: 'Name',
                    controller: _nameController,
                    preIcon: Icon(Icons.person, color: Colors.white),
                  ),

                  SizedBox(height: 16.h),

                  CustomTextFormField(
                    hintText: 'Phone',
                    controller: _phoneController,
                    preIcon: Icon(Icons.call, color: Colors.white),
                  ),

                  SizedBox(height: 20.h),

                  if (_showAvatarPicker) _buildAvatarPicker(),

                  SizedBox(height: 300.h),
                  BlocListener<ProfileCubit, ProfileState>(
                    listener: (context, state) {
                      if (state is DeleteProfileLoading) {
                        UiUtils.hideLoadingDialog(context);
                      } else if (state is DeleteProfileError) {
                        UiUtils.hideLoadingDialog(context);
                        UiUtils.showToastNotificationBar(
                          context,
                          state.message,
                          ColorsManager.white,
                          ColorsManager.red,
                          Icons.error,
                        );
                      } else if (state is DeleteProfileSuccess) {
                        
                        UiUtils.hideLoadingDialog(context);
                        UiUtils.showToastNotificationBar(
                          context,
                          "Profile Updated Successfully",
                          ColorsManager.white,
                          ColorsManager.green,
                          Icons.check_circle,
                        );
                        if (!mounted) return; // ✅ تأكد من أن الـ widget موجودة
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutesManager.login,
                          (route) => false, // يمسح كل الـ previous routes
                        );
                      }
                    },
                    child: CustomElevatedButton(
                      text: "Delete Account",
                      color: ColorsManager.red,
                      textColor: ColorsManager.white,
                      onPress: () {
                        BlocProvider.of<ProfileCubit>(context).deleteProfile();
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomElevatedButton(
                    text: "Update Data",
                    onPress: () {
                      final cubit = context.read<ProfileCubit>();

                      cubit.editProfile(
                        widget.email,
                        _selectedAvatar,
                        _nameController.text,
                        _phoneController.text,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatarPicker() {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.black,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
        ),
        itemCount: Avatar.avatars.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedAvatar;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedAvatar = index;
                _showAvatarPicker = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? ColorsManager.yellow : Colors.transparent,
                  width: 3.w,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    Avatar.avatars[index].bath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
