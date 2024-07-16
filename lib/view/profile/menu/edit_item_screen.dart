import 'dart:io';
import 'package:dineease/model/restro/item.dart';
import 'package:dineease/style/components/snackbar.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/utils/image_picker.dart';
import 'package:dineease/view_model/restro/items_vm.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditItemScreen extends StatefulWidget {
  final Item? item;

  const EditItemScreen({
    super.key,
    required this.item,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  String? _selectedDepartment = 'food';
  File? _pickedImage;

  Future<void> _pickImage() async {
    File? image = await ImagePickerUtil.pickImageFromGallery();
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemDescriptionController = TextEditingController();

  void _loadData() {
    itemNameController.text = widget.item!.name;
    itemPriceController.text = widget.item!.price;
    itemDescriptionController.text = widget.item!.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Item",
          style: MyTextStyle.title,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.widthPadding * 1.3),
            child: InkWell(
              onTap: () {
                final itemVM =
                    Provider.of<ItemViewModel>(context, listen: false);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text(
                      'Are you sure?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Are you sure you want to delete this item from the menu?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: 'Poppins-Medium',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              InkWell(
                                onTap: () {
                                  itemVM.deleteItem(widget.item!.id.toString());
                                  MySnackBar.showSnackBar(
                                      context, 'Item Deleted Successfully');

                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: 'Poppins-Medium',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                width: screenWidth * 0.2,
                height: screenHeight * 0.04,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.primaryColor),
                child: Center(
                  child: Text(
                    "Delete",
                    style: MyTextStyle.caption.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalpadding * 1.5),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Dish Name",
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
                  controller: itemNameController,
                  keyboardType: TextInputType.text,
                  style: MyTextStyle.body,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: AppConstants.bannerPadding),
                    hintText: "Enter your Dish name",
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
                const SizedBox(height: AppConstants.verticalpadding * 2.5),
                Row(
                  children: [
                    Text(
                      "Department",
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
                DropdownButtonHideUnderline(
                  child: Container(
                    height: 50,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButton<String>(
                      value: _selectedDepartment,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.black),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedDepartment = newValue;
                        });
                      },
                      dropdownColor: Colors.white,
                      items: <String>[
                        'food',
                        'drink',
                        'bar',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: MyTextStyle.subtitle.copyWith(fontSize: 13),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.verticalpadding * 1.5),
                Row(
                  children: [
                    Text(
                      "Price",
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
                  controller: itemPriceController,
                  keyboardType: TextInputType.text,
                  style: MyTextStyle.body,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: AppConstants.bannerPadding),
                    hintText: "Enter the price ",
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
                const SizedBox(height: AppConstants.verticalpadding * 1.5),
                Text(
                  "Description",
                  style: MyTextStyle.subtitle.copyWith(fontSize: 14),
                ),
                const SizedBox(height: AppConstants.verticalpadding * 1.5),
                SizedBox(
                  height: 150,
                  child: TextFormField(
                    controller: itemDescriptionController,
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
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      if (itemNameController.text.isNotEmpty &&
                          itemPriceController.text.isNotEmpty &&
                          itemDescriptionController.text.isNotEmpty &&
                          _selectedDepartment != null &&
                          _pickedImage != null) {
                        final itemVM =
                            Provider.of<ItemViewModel>(context, listen: false);

                        itemVM.editItem(
                          widget.item!.id.toString(),
                          itemNameController.text,
                          itemPriceController.text,
                          itemDescriptionController.text,
                          _pickedImage!,
                          _selectedDepartment!,
                        );
                        MySnackBar.showSnackBar(
                            context, 'Item Edited Successfully');
                        _pickedImage = null;
                        Navigator.pop(context);
                      } else {
                        MySnackBar.showSnackBar(
                            context, 'Please fill all fields');
                      }
                    }
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
        ),
      ),
    );
  }
}
