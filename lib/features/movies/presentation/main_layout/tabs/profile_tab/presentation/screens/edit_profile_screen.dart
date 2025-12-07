import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/assets_manager.dart';
import 'package:movies_app/core/resources/colors_manager.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentPhone;
  final String currentAvatar;

  const EditProfileScreen({
    Key? key,
    required this.currentName,
    required this.currentPhone,
    required this.currentAvatar,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late String _selectedAvatar;
  bool _showAvatarPicker = false;

  final List<String> _avatars = [
    ImagesAssets.avatar1,
    ImagesAssets.avatar2,
    ImagesAssets.avatar3,
    ImagesAssets.avatar4,
    ImagesAssets.avatar5,
    ImagesAssets.avatar6,
    ImagesAssets.avatar7,
    ImagesAssets.avatar9
  ];

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
    return Scaffold(
      backgroundColor: ColorsManager.black,
      appBar: AppBar(
        backgroundColor: ColorsManager.grey,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorsManager.white,
            size: 24.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pick Avatar',
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
                  setState(() {
                    _showAvatarPicker = !_showAvatarPicker;
                  });
                },
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundColor: ColorsManager.white,

                      child: ClipOval(
                        child: Image.asset(
                          ImagesAssets.avatar8,
                          width: 120.w,
                          height: 120.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: 60.sp,
                              color: ColorsManager.white,
                            );
                          },
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
                            color:  ColorsManager.black,
                            width: 3.w,
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: ColorsManager.black,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              CustomTextFormField(hintText: 'John Safwat',
                preIcon: Icon(
                  Icons.person,
                  color: ColorsManager.white,
                  size: 24.sp,
                ),
                controller: _nameController,


              ),
              SizedBox(height: 16.h),
              // _buildInputField(
              //   controller: _nameController,
              //   icon: Icons.person,
              //   hintText: 'John Safwat',
              //   enabled: !_showAvatarPicker,
              // ),
              SizedBox(height: 16.h),
              CustomTextFormField(hintText: '01200000000',preIcon: Icon(Icons.call,color: ColorsManager.white,size: 24.sp,),controller: _nameController,),

              // _buildInputField(
              //   controller: _phoneController,
              //   icon: Icons.phone,
              //   hintText: '01200000000',
              //   enabled: false, // Phone is disabled in the design
              // ),
              SizedBox(height: 30.h),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: _showAvatarPicker ? null : _handleResetPassword,
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      color: _showAvatarPicker
                          ? Colors.grey
                          : Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              if (_showAvatarPicker) ...[
                SizedBox(height: 20.h),
                _buildAvatarPicker(),
              ],
              SizedBox(height: 280.h),
              if (!_showAvatarPicker) ...[
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: _showDeleteAccountDialog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.red,
                      foregroundColor: ColorsManager.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Delete Account',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: _handleUpdateData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  ColorsManager.yellow,
                      foregroundColor: ColorsManager.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Update Data',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    bool enabled = true,
  }) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: ColorsManager.black,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: ColorsManager.grey.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        style: TextStyle(
          color: enabled ? Colors.white : Colors.grey,
          fontSize: 16.sp,
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: ColorsManager.white,
            size: 24.sp,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16.sp,
          ),
          border: InputBorder.none,
        ),
      ),
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
        itemCount: _avatars.length,
        itemBuilder: (context, index) {
          final avatar = _avatars[index];
          final isSelected = avatar == _selectedAvatar;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedAvatar = avatar;
                _showAvatarPicker = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? ColorsManager.yellow
                      : Colors.transparent,
                  width: 3.w,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: ColorsManager.white,
                child: ClipOval(
                  child: Image.asset(
                    avatar,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.person,
                        size: 30.sp,
                        color: Colors.white,
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleResetPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorsManager.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Reset Password',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'A password reset link will be sent to your registered email.',
            style: TextStyle(
              color: ColorsManager.grey,
              fontSize: 16.sp,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.sp,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add reset password logic here
                _showSuccessSnackbar('Password reset link sent!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.yellow,
                foregroundColor: ColorsManager.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Send',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorsManager.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Delete Account',
            style: TextStyle(
              color: ColorsManager.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            style: TextStyle(
              color: ColorsManager.grey,
              fontSize: 16.sp,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: ColorsManager.grey,
                  fontSize: 16.sp,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Add delete account logic here
                Navigator.of(context).pop(); // Go back to profile
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.red,
                foregroundColor: ColorsManager.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Delete',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleUpdateData() {
    // Add validation if needed
    if (_nameController.text.isEmpty) {
      _showErrorSnackbar('Name cannot be empty');
      return;
    }

    // Return updated data to previous screen
    Navigator.pop(context, {
      'name': _nameController.text,
      'phone': _phoneController.text,
      'avatar': _selectedAvatar,
    });

    _showSuccessSnackbar('Profile updated successfully!');
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ColorsManager.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ColorsManager.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}