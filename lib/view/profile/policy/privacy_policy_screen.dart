import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view_model/profile/privacy_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PrivacyViewModel>(context, listen: false).fetchItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final privacy = Provider.of<PrivacyViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.screenPadding,
              vertical: AppConstants.verticalpadding * 5),
          child: Column(
            children: [
              Text(
                privacy.infos[0].content,
                style: MyTextStyle.body,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
