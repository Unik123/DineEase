import 'dart:io';
import 'package:dineease/model/profile/team.dart';
import 'package:dineease/style/components/snackbar.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/utils/image_picker.dart';
import 'package:dineease/view_model/profile/our_team_vm.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTeamMember extends StatefulWidget {
  final Team team;
  const EditTeamMember({
    super.key,
    required this.team,
  });

  @override
  State<EditTeamMember> createState() => _EditTeamMemberState();
}

class _EditTeamMemberState extends State<EditTeamMember> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    File? image = await ImagePickerUtil.pickImageFromGallery();
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  final nameController = TextEditingController();
  final positonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.team.name;
    positonController.text = widget.team.role;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Team Member",
          style: MyTextStyle.title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalpadding * 1.5),
        child: Column(
          children: [
            const SizedBox(height: AppConstants.verticalpadding * 2),
            Row(
              children: [
                Text(
                  "Full Name",
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
              controller: nameController,
              keyboardType: TextInputType.text,
              style: MyTextStyle.body,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: AppConstants.bannerPadding),
                hintText: "Enter a name",
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
            const SizedBox(height: AppConstants.verticalpadding * 2.5),
            InkWell(
              onTap: _pickImage,
              child: DottedBorder(
                color: Colors.red,
                strokeWidth: 1,
                stackFit: StackFit.loose,
                child: Container(
                  height: 90,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.15),
                  ),
                  child: _pickedImage == null
                      ? Column(
                          children: [
                            const SizedBox(
                                height: AppConstants.verticalpadding * 4),
                            const Icon(Icons.file_upload_outlined),
                            const SizedBox(
                                height: AppConstants.verticalpadding),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Select Photos",
                                    style: MyTextStyle.subtitle.copyWith(
                                      fontSize: 11,
                                      color: Colors.red,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        " from library or upload your own photo",
                                    style: MyTextStyle.subtitle.copyWith(
                                      fontSize: 11,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _pickedImage!,
                            fit: BoxFit.cover,
                            height: 90,
                            width: double.maxFinite,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: AppConstants.verticalpadding * 1.5),
            const SizedBox(height: AppConstants.verticalpadding * 2),
            Row(
              children: [
                Text(
                  "Position",
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
              controller: positonController,
              keyboardType: TextInputType.text,
              style: MyTextStyle.body,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: AppConstants.bannerPadding),
                hintText: "Enter a Position",
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
                if (nameController.text != widget.team.name ||
                    positonController.text != widget.team.role ||
                    _pickedImage != null) {
                  final teamVM =
                      Provider.of<OurTeamViewModel>(context, listen: false);
                  teamVM.updateTeamMember(
                    widget.team.id.toString(),
                    nameController.text,
                    _pickedImage!,
                    positonController.text,
                  );
                } else {
                  MySnackBar.showSnackBar(context, 'No changes made!');
                }
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
    );
  }
}
