import 'package:dineease/style/theme/text_styles.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        CircleAvatar,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        Expanded,
        GestureDetector,
        Icon,
        IconData,
        Icons,
        MainAxisAlignment,
        Row,
        SizedBox,
        StatelessWidget,
        Text,
        Theme,
        VoidCallback,
        Widget;

class DefaultListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final IconData icon;

  const DefaultListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        padding: const EdgeInsets.symmetric(vertical: 7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              radius: 20,
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: MyTextStyle.body),
                  Text(subtitle, style: MyTextStyle.thin),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            )
          ],
        ),
      ),
    );
  }
}
