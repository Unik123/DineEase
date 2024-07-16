// import 'dart:io';
import 'package:dineease/model/profile/profile.dart';
import 'package:dineease/style/components/snackbar.dart';
import 'package:dineease/view_model/profile/profile_vm.dart';
import 'package:flutter/material.dart';
// import 'pa:image_picker/image_picker.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final Profile user;

  const EditProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // File? _pickedImage;

  // Future<void> _pickImage() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _pickedImage = File(pickedFile.path);
  //     });
  //   }
  // }

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    firstNameController.text = widget.user.firstName!;
    lastNameController.text = widget.user.lastName!;
    addressController.text = widget.user.address!;
    phoneController.text = widget.user.contact!;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: MyTextStyle.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalpadding * 1.5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Basic Profile info",
                style: MyTextStyle.body.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 2),
              Text(
                "Fill up your basic profile details",
                style: MyTextStyle.subtitle.copyWith(fontSize: 11),
              ),
              const SizedBox(height: AppConstants.verticalpadding * 3),
              // Row(
              //   children: [
              //     Text(
              //       "Profile Picture",
              //       style: MyTextStyle.subtitle.copyWith(fontSize: 14),
              //     ),
              //     Text(
              //       " *",
              //       style: MyTextStyle.subtitle
              //           .copyWith(fontSize: 14, color: Colors.red),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: AppConstants.verticalpadding * 2),
              // InkWell(
              //   onTap: _pickImage,
              //   child: Container(
              //     height: 90,
              //     width: 90,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(7),
              //       color: Colors.red.withOpacity(0.15),
              //       image: _pickedImage != null
              //           ? DecorationImage(
              //               image: FileImage(_pickedImage!),
              //               fit: BoxFit.cover,
              //             )
              //           : null,
              //     ),
              //     child: _pickedImage == null
              //         ? const Icon(
              //             Icons.add,
              //             color: Colors.grey,
              //           )
              //         : null,
              //   ),
              // ),
              const SizedBox(height: AppConstants.verticalpadding * 2),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "First Name",
                              style:
                                  MyTextStyle.subtitle.copyWith(fontSize: 14),
                            ),
                            Text(
                              " *",
                              style: MyTextStyle.subtitle
                                  .copyWith(fontSize: 14, color: Colors.red),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: AppConstants.verticalpadding * 1.5),
                        TextFormField(
                          controller: firstNameController,
                          keyboardType: TextInputType.text,
                          style: MyTextStyle.body,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: AppConstants.bannerPadding),
                            hintText: "First name",
                            hintStyle:
                                MyTextStyle.subtitle.copyWith(fontSize: 13),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade600),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppConstants.horizontalpadding * 2),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Last Name",
                              style:
                                  MyTextStyle.subtitle.copyWith(fontSize: 14),
                            ),
                            Text(
                              " *",
                              style: MyTextStyle.subtitle
                                  .copyWith(fontSize: 14, color: Colors.red),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: AppConstants.verticalpadding * 1.5),
                        TextFormField(
                          controller: lastNameController,
                          keyboardType: TextInputType.text,
                          style: MyTextStyle.body,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: AppConstants.bannerPadding),
                            hintText: "Last name",
                            hintStyle:
                                MyTextStyle.subtitle.copyWith(fontSize: 13),
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade600),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.verticalpadding * 2),
              Row(
                children: [
                  Text(
                    "Address",
                    style: MyTextStyle.subtitle.copyWith(fontSize: 14),
                  ),
                  Text(
                    " *",
                    style: MyTextStyle.subtitle
                        .copyWith(fontSize: 14, color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.verticalpadding * 1.5),
              TextFormField(
                controller: addressController,
                keyboardType: TextInputType.text,
                style: MyTextStyle.body,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: AppConstants.bannerPadding),
                  hintText: "Enter your address",
                  hintStyle: MyTextStyle.subtitle.copyWith(fontSize: 13),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.verticalpadding * 2),
              Text(
                "Email",
                style: MyTextStyle.subtitle.copyWith(fontSize: 14),
              ),
              const SizedBox(height: AppConstants.verticalpadding * 1.5),
              Container(
                height: 45,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    border: Border.all(width: 0.3),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
                  child: Text(
                    widget.user.email!,
                    style: MyTextStyle.subtitle.copyWith(
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.verticalpadding * 2),
              Row(
                children: [
                  Text(
                    "Contact",
                    style: MyTextStyle.subtitle.copyWith(fontSize: 14),
                  ),
                  Text(
                    " *",
                    style: MyTextStyle.subtitle
                        .copyWith(fontSize: 14, color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.verticalpadding * 1.5),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.text,
                style: MyTextStyle.body,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: AppConstants.bannerPadding),
                  hintText: "9800000000",
                  hintStyle: MyTextStyle.subtitle.copyWith(fontSize: 13),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade600),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.verticalpadding * 5),
              GestureDetector(
                onTap: () {
                  final profileVM =
                      Provider.of<ProfileViewModel>(context, listen: false);

                  profileVM.updateProfile(
                    Profile(
                      id: widget.user.id,
                      username: widget.user.username,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      email: widget.user.email,
                      role: widget.user.role,
                      address: addressController.text,
                      contact: phoneController.text,
                    ),
                  );

                  MySnackBar.showSnackBar(
                      context, 'Profile Updated Successfully!');

                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.primaryColor),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: MyTextStyle.thin
                          .copyWith(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
