import 'package:flutter/material.dart';
import 'package:nat_corp_admin/utils/colors.dart';
import 'package:nat_corp_admin/widgets/text_widget.dart';

PreferredSizeWidget AppbarWidget(
  String title,
) {
  return AppBar(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: KgreyColor,
    title: TextBold(text: title, fontSize: 18, color: Colors.white),
    centerTitle: true,
  );
}
