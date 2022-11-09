import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khetma/presentation/resources/font_manager.dart';
import 'package:khetma/presentation/resources/theme_manager.dart';
import 'package:khetma/presentation/resources/views_manager.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../controllers/quran/quran_bloc.dart';
import '../../../util/util_manager.dart';

class MiniSetting extends StatelessWidget {
  MiniSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return miniSettings(context);
  }

  // ------------ settings -------------
  Widget miniSettings(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.grey.shade50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UtilM.box20(),
              backBT(context),
              UtilM.box20(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("نوع الخط : "),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: chiceFont(context))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("حجم الخط : "),
                  Expanded(child: fontSlider()),
                ],
              ),
              UtilM.box20()
            ],
          ),
        ),
      );

  Widget backBT(context) => Container(
    child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: ()  => ViewsManager.backIfUCan(context),
              child:  const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.blue,
              ),
            ),
          ],
        ),
  );

  Widget chiceFont(context) => BlocBuilder<QuranBloc, QuranState>(
        buildWhen: (p, c) => c is QSFontFamily,
        builder: (context, state) {
          return ChipsChoice.single(
            value: QuranBloc.get(context).fontFamily,
            onChanged: (v) {
              print(v);
              QuranBloc.get(context).changeFamilyFont(v);
            },
            choiceItems: [
              oneChoice(FontConstant.fontUthmani2, "عثماني"),
              oneChoice(FontConstant.fontHafss, "حفص"),
              oneChoice(FontConstant.fontAmiri, "اميري"),
            ],
            choiceStyle: const C2ChipStyle(checkmarkColor: Colors.cyanAccent),
          );
        },
      );

  C2Choice oneChoice(String value, String lable) => C2Choice(
        value: value,
        label: lable,
        style: C2ChipStyle(foregroundStyle: TextStyle(fontFamily: value)),
      );

  // ----------------- slider font -----------------

  Widget fontSlider() => BlocBuilder<QuranBloc, QuranState>(
        buildWhen: (p, c) => c is QSSliderFontChange,
        builder: (context, state) {
          QuranBloc _cubit = QuranBloc.get(context);
          return SfSliderTheme(
            data: SfSliderThemeData(
              thumbColor: Colors.pinkAccent,
              activeLabelStyle: const TextStyle(
                  color: Colors.red, fontSize: 12, fontStyle: FontStyle.italic),
              inactiveLabelStyle: TextStyle(
                  color: Colors.red[100],
                  fontSize: 12,
                  fontStyle: FontStyle.italic),
              activeTrackHeight: 2,
              inactiveTrackHeight: 1,
              thumbRadius: (_cubit.sliderFontValue) / 7 + 3,
            ),
            child: SfSlider(
              min: _cubit.sliderFontMinValue,
              max: _cubit.sliderFontMaxValue,
              value: _cubit.sliderFontValue,
              interval: 4,
              showTicks: true,
              showLabels: true,
              enableTooltip: true,
              minorTicksPerInterval: 1,
              labelPlacement: LabelPlacement.onTicks,
              stepSize: 2,
              inactiveColor: Colors.grey,
              onChanged: (dynamic value) {
                _cubit.changeFontValue(value);
              },
              onChangeEnd: (v) {
                _cubit.endChangeFontValue(v);
              },
            ),
          );
        },
      );
}
