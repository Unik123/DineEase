import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/view/profile/policy/privacy_policy_screen.dart';
import 'package:dineease/view/profile/policy/terms_condition.dart';
import 'package:flutter/material.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Policies",
            style: MyTextStyle.title,
          ),
          bottom: const TabBar(
            labelStyle: MyTextStyle.body,
            tabs: [
              Tab(text: "Privacy Policy"),
              Tab(text: "T & C"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PrivacyPolicyScreen(),
            TermsCondition(),
          ],
        ),
      ),
    );
  }
}
