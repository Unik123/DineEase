import 'package:dineease/model/profile/profile.dart';
import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view/profile/about_us/edit_about_us.dart';
import 'package:dineease/view_model/profile/about_us_vm.dart';
import 'package:dineease/view_model/profile/profile_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AboutUsViewModel>(context, listen: false).fetchInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final infos = Provider.of<AboutUsViewModel>(context).infos;
    final info = infos.first;

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final profileVM = Provider.of<ProfileViewModel>(context, listen: false);
    final Profile user = profileVM.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: MyTextStyle.title,
        ),
        actions: [
          if (user.role == 'admin')
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.widthPadding * 1.3),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditAboutUs(info: info);
                      },
                    ),
                  );
                },
                child: Container(
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.04,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: Center(
                    child: Text(
                      "Edit",
                      style: MyTextStyle.body.copyWith(
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
        padding: const EdgeInsets.all(AppConstants.screenPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage(info.logo),
                    ),
                    const SizedBox(height: AppConstants.verticalpadding * 3),
                    Text(info.name, style: MyTextStyle.title),
                    const Text(
                      "Eat well Live well",
                      style: MyTextStyle.subtitle,
                    ),
                    const SizedBox(height: AppConstants.verticalpadding * 2),
                    Text(info.address, style: MyTextStyle.body),
                    Text(info.contact, style: MyTextStyle.body),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.verticalpadding * 5),
              const Text('Description', style: MyTextStyle.title),
              const SizedBox(height: AppConstants.verticalpadding * 2),
              HtmlWidget(info.description),
            ],
          ),
        ),
      ),
    );
  }
}
