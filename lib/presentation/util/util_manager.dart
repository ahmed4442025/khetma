import 'package:flutter/material.dart';
import 'package:khetma/presentation/resources/theme_manager.dart';
import 'package:khetma/presentation/util/w/me/search_bar.dart';
import 'package:khetma/presentation/util/w/p/label_selecet.dart';
import '../resources/values_manager.dart';

class UtilM {
  static SizedBox box5() =>
      const SizedBox(height: AppSize.s5, width: AppSize.s5);

  static SizedBox box10() =>
      const SizedBox(height: AppSize.s10, width: AppSize.s10);

  static SizedBox box15() =>
      const SizedBox(height: AppSize.s15, width: AppSize.s15);

  static SizedBox box20() =>
      const SizedBox(height: AppSize.s20, width: AppSize.s20);

  static SizedBox box30() =>
      const SizedBox(height: AppSize.s30, width: AppSize.s30);

  static SizedBox box40() =>
      const SizedBox(height: AppSize.s40, width: AppSize.s40);

  static SizedBox box60() =>
      const SizedBox(height: AppSize.s60, width: AppSize.s60);

  static SizedBox box100() =>
      const SizedBox(height: AppSize.s100, width: AppSize.s100);

  static iconButton(VoidCallback onTap, IconData icon, String text) =>
      TextButton.icon(
          onPressed: onTap,
          icon: Icon(
            icon,
            size: AppSize.s30,
          ),
          label: Text(
            '  $text',
            style: ThemeManager.currentThem.textTheme.headlineMedium,
          ));

// ========= big ==========
  static LabelSelectedList labelSelected(
          {List<LabelSelectedModel>? listLabels}) =>
      LabelSelectedList(listLabels ?? []);

  static searchBar({ValueChanged<String>? onChanged}) =>
      SearchTextField(onChanged: onChanged);
}
