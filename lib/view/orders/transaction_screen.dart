import 'package:dineease/model/profile/profile.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/colors.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view_model/profile/profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatelessWidget {
  final double totalAmount;
  final String paymentMethod;

  const TransactionScreen({
    super.key,
    required this.totalAmount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final profileVM = Provider.of<ProfileViewModel>(context, listen: false);
    final Profile user = profileVM.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Transaction Details",
          style: MyTextStyle.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage("assets/images/dine.jpeg"),
            ),
            const Text(
              "Dine Ease",
              style: MyTextStyle.title,
            ),
            const Text(
              "Eat well Live well",
              style: MyTextStyle.subtitle,
            ),
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              height: 340,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Dine Ease Topup", style: MyTextStyle.title),
                          SizedBox(height: 4.0),
                          Text("2024-06-11 02:00 PM",
                              style: MyTextStyle.subtitle),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "RS $totalAmount",
                            style: MyTextStyle.title
                                .copyWith(color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text("COMPLETE",
                        style: MyTextStyle.body.copyWith(
                            color: AppColors.secondaryColor, fontSize: 14)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(height: 20.0, color: Colors.grey),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount (NPR):", style: MyTextStyle.body),
                      Text("RS $totalAmount", style: MyTextStyle.body),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Channel:", style: MyTextStyle.body),
                      Text("App", style: MyTextStyle.body),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Transaction Code:", style: MyTextStyle.body),
                      Text("0L9P9R9", style: MyTextStyle.body),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Processed By:", style: MyTextStyle.body),
                      Text("0X78U", style: MyTextStyle.body),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Mobile Number:", style: MyTextStyle.body),
                      Text(user.contact!, style: MyTextStyle.body),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Payment Method:", style: MyTextStyle.body),
                      Text(paymentMethod, style: MyTextStyle.body),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.verticalpadding * 3),
            SizedBox(
              width: screenWidth * 0.8,
              height: screenHeight * 0.056,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Done',
                  style: MyTextStyle.body.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
