import 'package:flutter/material.dart';

//Reusable AppBar
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Text title;
  final Color backgroundColor;
  final Widget leading;
  final List<Widget> widgets;
  final AppBar appBar;
  const BaseAppBar(
      {Key key,
      this.title,
      this.backgroundColor,
      this.appBar,
      this.widgets,
      this.leading})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: backgroundColor,
      actions: widgets,
      leading: leading,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
