import 'package:dineease/model/restro/restro_info.dart';
import 'package:dineease/style/components/snackbar.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
// import 'dart:io';
// import 'package:dineease/utils/image_picker.dart';
// import 'package:dotted_border/dotted_border.dart';
import 'package:dineease/view_model/profile/about_us_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAboutUs extends StatefulWidget {
  final RestroInfo info;
  const EditAboutUs({
    super.key,
    required this.info,
  });

  @override
  State<EditAboutUs> createState() => _EditAboutUsState();
}

class _EditAboutUsState extends State<EditAboutUs> {
  // File? _pickedImage;

  // Future<void> _pickImage() async {
  //   File? image = await ImagePickerUtil.pickImageFromGallery();
  //   if (image != null) {
  //     setState(() {
  //       _pickedImage = image;
  //     });
  //   }
  // }

  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    addressController.text = widget.info.address;
    contactController.text = widget.info.contact;
    descriptionController.text = widget.info.description;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Detail",
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
                hintText: "Enter your Address",
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
            Row(
              children: [
                Text(
                  "Phone Number",
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
              controller: contactController,
              keyboardType: TextInputType.text,
              style: MyTextStyle.body,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: AppConstants.bannerPadding),
                hintText: "Enter your phone number",
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
            // InkWell(
            //   onTap: _pickImage,
            //   child: DottedBorder(
            //     color: Colors.red,
            //     strokeWidth: 1,
            //     stackFit: StackFit.loose,
            //     child: Container(
            //       height: 90,
            //       width: double.maxFinite,
            //       decoration: BoxDecoration(
            //         color: Colors.red.withOpacity(0.15),
            //       ),
            //       child: _pickedImage == null
            //           ? Column(
            //               children: [
            //                 const SizedBox(
            //                     height: AppConstants.verticalpadding * 4),
            //                 const Icon(Icons.file_upload_outlined),
            //                 const SizedBox(
            //                     height: AppConstants.verticalpadding),
            //                 RichText(
            //                   text: TextSpan(
            //                     children: [
            //                       TextSpan(
            //                         text: "Select Photos",
            //                         style: MyTextStyle.subtitle.copyWith(
            //                           fontSize: 11,
            //                           color: Colors.red,
            //                         ),
            //                       ),
            //                       TextSpan(
            //                         text:
            //                             " from library or upload your own photo",
            //                         style: MyTextStyle.subtitle.copyWith(
            //                           fontSize: 11,
            //                           color: Colors.black.withOpacity(0.5),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             )
            //           : ClipRRect(
            //               borderRadius: BorderRadius.circular(10),
            //               child: Image.file(
            //                 _pickedImage!,
            //                 fit: BoxFit.cover,
            //                 height: 90,
            //                 width: double.maxFinite,
            //               ),
            //             ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: AppConstants.verticalpadding * 1.5),
            Row(
              children: [
                Text(
                  "Description",
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
            SizedBox(
              height: 150,
              child: TextFormField(
                controller: descriptionController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                keyboardType: TextInputType.multiline,
                style: MyTextStyle.body,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: AppConstants.bannerPadding),
                  hintText: "Description",
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
            ),
            const SizedBox(height: AppConstants.verticalpadding * 5),
            GestureDetector(
              onTap: () {
                final infoVM =
                    Provider.of<AboutUsViewModel>(context, listen: false);

                infoVM.updateInfo(
                  RestroInfo(
                    id: widget.info.id,
                    name: widget.info.name,
                    email: widget.info.email,
                    logo: widget.info.logo,
                    createdAt: widget.info.createdAt,
                    address: addressController.text,
                    contact: contactController.text,
                    description: descriptionController.text,
                  ),
                );

                MySnackBar.showSnackBar(context, "Info Edited Successfully");
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
                    "Edit",
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
