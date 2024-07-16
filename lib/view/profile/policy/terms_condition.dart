import 'package:dineease/style/theme/text_styles.dart';
import 'package:dineease/utils/constants.dart';
import 'package:dineease/view_model/profile/terms_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TACViewModel>(context, listen: false).fetchItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final terms = Provider.of<TACViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.screenPadding,
              vertical: AppConstants.verticalpadding * 5),
          child: Column(
            children: [
              Text(
                terms.infos[0].content,
                style: MyTextStyle.subtitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
