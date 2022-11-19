import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khetma/presentation/resources/views_manager.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../controllers/quran/quran_bloc.dart';
import '../../../util/util_manager.dart';

class MiniSetting extends StatelessWidget {
  void Function() backVoid;

  MiniSetting({Key? key, required this.backVoid}) : super(key: key);

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
                  const Expanded(flex: 2, child: Text("نوع الخط : ")),
                  Expanded(
                    flex: 7,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: choiceFontFamily(context)),
                  )
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

  Widget backBT(context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => onBack(context),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.blue,
            ),
          ),
        ],
      );

  Widget choiceFontFamily(context) => BlocBuilder<QuranBloc, QuranState>(
        buildWhen: (p, c) => c is QSFontFamily,
        builder: (context, state) {
          return ChipsChoice.single(
            value: QuranBloc.get(context).fontFamily,
            onChanged: (v) {
              QuranBloc.get(context).changeFamilyFont(v as String);
            },
            choiceItems: QuranBloc.get(context)
                .fontList
                .map((e) => oneChoice(e))
                .toList(),
            choiceStyle: const C2ChipStyle(checkmarkColor: Colors.cyanAccent),
          );
        },
      );

  C2Choice oneChoice(FontModel fontModel) => C2Choice(
        value: fontModel.family,
        label: fontModel.name,
        style: C2ChipStyle(
            foregroundStyle: TextStyle(fontFamily: fontModel.family)),
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

  // on back
  void onBack(context) {
    backVoid();
    ViewsManager.backIfUCan(context);
  }
}

class FontModel {
  String family;
  String name;

  FontModel(this.family, this.name);
}
