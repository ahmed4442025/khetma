import 'package:flutter/material.dart';
import 'package:khetma/presentation/views/quran/views/faqra_view/faqra_view.dart';
import '../../domain/models/faqra.dart';
import '../views/quran/views/faqra_view/faqra_view_model.dart';
import 'routes_maneger.dart';

class ViewsManager {
  // =============== const pages =================
  // ------------ with out back ------------

  // homeAfterSplash
  static void homeAfterSplash(context) {
    home(context);
  }

  // home
  static void home(context) {
    _openViewNoBack(context, Routes.home);
  }

  // temp
  static void temp(context) {
    _openViewNoBack(context, Routes.temp);
  }

  // temp2
  static void temp2(context) {
    _openViewNoBack(context, Routes.temp2);
  }

  // ------------ with back ------------
  // NOTE : "WB" (with back) in the end of function name that mean you can use back button

  // quran content
  static void QuranContentWB(context, FaqraData faqraData) {
    _openViewWithBack(context, Routes.surahView, arguments: faqraData);
  }

  // add or edit new group
  static void addNewGroup(context, {int? groupIndex}) {
    _openViewWithBack(context, Routes.addNewGroupView,arguments: groupIndex);
  }

  // go back if you can
  static void backIfUCan(context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  // ========== privet methods ==========

  // user can't back to last page
  static void _openViewNoBack(context, nextPage, {Object? arguments}) {
    Navigator.of(context).pushNamedAndRemoveUntil(nextPage, (route) => false,
        arguments: arguments);
  }

  // user can back to last page
  static void _openViewWithBack(context, nextPage, {Object? arguments}) {
    Navigator.of(context).pushNamed(nextPage, arguments: arguments);
  }
}
