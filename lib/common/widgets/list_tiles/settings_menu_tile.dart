import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle,
    this.trailing,
    this.onTap,
    this.color = TColors.primary,
  });

  final IconData icon;
  final String title;
  final String? subTitle;
  final Color? color;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28, color: color),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: subTitle != null ? Text(subTitle!, style: Theme.of(context).textTheme.labelMedium) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
