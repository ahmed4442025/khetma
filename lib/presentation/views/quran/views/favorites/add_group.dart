import 'package:flutter/material.dart';
import 'package:khetma/controllers/home/home_bloc.dart';
import 'package:khetma/presentation/resources/theme_manager.dart';
import 'package:khetma/presentation/resources/views_manager.dart';
import 'package:khetma/presentation/util/util_manager.dart';
import 'package:quran/quran.dart' as quran;
import 'package:collection/collection.dart';

import '../../../../../domain/models/faqra.dart';

class AddNewGroupView extends StatefulWidget {
  AddNewGroupView({this.groupIndex, Key? key}) : super(key: key);
  int? groupIndex;

  @override
  State<AddNewGroupView> createState() => _AddNewGroupViewState();
}

class _AddNewGroupViewState extends State<AddNewGroupView> {
  late GroupQuran _myGroup;
  late final HomeBloc _bloc;

  // dd
  _SorahModel? currentSurah;
  int? ayaStart;
  int? ayaEnd;
  int? selectedIndex;
  late final List<_SorahModel> listAllSurah;
  final TextEditingController _nameCTR = TextEditingController();

  List<_SorahModel> genList() {
    List<_SorahModel> l = [];
    for (int i = 1; i <= quran.totalSurahCount; i++) {
      l.add(_SorahModel(i));
    }
    return l;
    l = [for (int i = 1; i <= quran.totalSurahCount; i++) _SorahModel(i)];
  }

  @override
  void initState() {
    super.initState();
    _bloc = HomeBloc.get(context);
    _myGroup = widget.groupIndex == null
        ? GroupQuran(FaqraModel([]), "ورد جديد")
        : _bloc.allGroups.listGroups[widget.groupIndex ?? 0];
    listAllSurah = genList();
    _nameCTR.text = _myGroup.name;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.groupIndex == null ? "اضافة ورد" : "تعديل ورد"),
          titleSpacing: 0,
          // centerTitle: true,
        ),
        body: myBody(),
      ),
    );
  }

  Widget myBody() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UtilM.box40(),
            name(),
            UtilM.box20(),
            dropDownSurah(listAllSurah),
            UtilM.box20(),
            Row(
              children: [
                if (currentSurah != null) dropDownAyaStart(),
                UtilM.box20(),
                if (ayaStart != null) dropDownAyaEnd(),
                // const Spacer(),
              ],
            ),
            UtilM.box20(),
            addBt(),
            editBt(),
            UtilM.box20(),
            allChoicese(),
            UtilM.box40(),
            saveBt(),
          ],
        ),
      );

  Widget name() => TextField(
      controller: _nameCTR,
      decoration: const InputDecoration(label: Text("اسم الورد")),
      onChanged: (v) {
        _myGroup.name = v;
      });

  // all choices
  Widget allChoicese() => Wrap(
        spacing: 4,
        runSpacing: 4,
        direction: Axis.vertical,
        children: _myGroup.faqraModel.listSurah
            .mapIndexed((index, element) => oneChip(element, index))
            .toList(),
      );

  // one chip
  Widget oneChip(FaqraSurahModel e, int index) => InputChip(
        selectedColor: ThemeManager.c.primary,
        backgroundColor: ThemeManager.c.primary.withOpacity(.2),
        labelStyle: const TextStyle(fontSize: 14),
        label: Row(
          children: [
            showSwap(index),
            Column(
              children: [
                Text(quran.getSurahNameArabic(e.id)),
                Text("${e.ayaEnd} - ${e.ayaStart}"),
              ],
            ),
          ],
        ),
        selected: index == selectedIndex,
        onPressed: () {
          // select
          if (selectedIndex == index) {
            selectedIndex = ayaEnd = ayaStart = currentSurah = null;
          } else {
            selectedIndex = index;
            currentSurah = listAllSurah[index];
            // ayaStart = _myGroup.faqraModel.listSurah[index].ayaStart;
            // ayaEnd = _myGroup.faqraModel.listSurah[index].ayaEnd;
            ayaStart = e.ayaStart;
            ayaEnd = e.ayaEnd;
          }
          setState(() {});
          print("ayaStart : $ayaStart , ayaEnd : $ayaEnd, surah id : ${currentSurah?.id}");
        },
        onDeleted: () {
          _myGroup.faqraModel.listSurah.removeAt(index);
          setState(() {});
        },
      );

  Widget showSwap(int index) {
    return (selectedIndex != null && selectedIndex != index)
        ? Row(children: [
            InkWell(
              onTap: () {
                // swap
                if (selectedIndex != null && selectedIndex != index) {
                  var temp = _myGroup.faqraModel.listSurah[selectedIndex!];
                  _myGroup.faqraModel.listSurah[selectedIndex!] =
                      _myGroup.faqraModel.listSurah[index];
                  _myGroup.faqraModel.listSurah[index] = temp;
                  selectedIndex = ayaEnd = ayaStart = currentSurah = null;
                  setState(() {});
                  return;
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: .5)),
                padding: EdgeInsets.all(3),
                child: Text(
                  "تبديل",
                  style: TextStyle(color: ThemeManager.c.darkPrimary),
                ),
              ),
            ),
            UtilM.box20()
          ])
        : const SizedBox.shrink();
  }

  // add bt
  Widget addBt() => (ayaEnd != null &&
          ayaStart != null &&
          currentSurah != null &&
          selectedIndex == null)
      ? ElevatedButton(
          onPressed: () {
            _myGroup.faqraModel.listSurah.add(FaqraSurahModel(
                currentSurah?.id ?? 1, ayaStart ?? 1, ayaEnd ?? 1));
            currentSurah = ayaStart = ayaEnd = null;
            setState(() {});
          },
          child: const Text('اضافة'),
        )
      : const SizedBox.shrink();

  // edit bt
  Widget editBt() => (selectedIndex != null)
      ? ElevatedButton(
          onPressed: () {
            if (selectedIndex == null) return;
            _myGroup.faqraModel.listSurah[selectedIndex!] = (FaqraSurahModel(
                currentSurah?.id ?? 1, ayaStart ?? 1, ayaEnd ?? 1));
            selectedIndex = currentSurah = ayaStart = ayaEnd = null;
            setState(() {});
          },
          child: const Text('تعديل'),
        )
      : const SizedBox.shrink();

  // save bt
  Widget saveBt() => (_myGroup.faqraModel.listSurah.isNotEmpty)
      ? ElevatedButton(
          onPressed: () {
            if (widget.groupIndex == null) {
              _bloc.addGroup(_myGroup);
            } else {
              _bloc.editGroup(widget.groupIndex ?? 0, _myGroup);
            }
            ViewsManager.backIfUCan(context);
          },
          child: const Text('حفظ'),
        )
      : const SizedBox.shrink();

  // list surah
  Widget dropDownSurah(List<_SorahModel> values) =>
      DropdownButtonFormField<_SorahModel>(
        decoration: const InputDecoration(
          label: Text("اختر سورة"),
        ),
        items: values
            .map((item) => DropdownMenuItem<_SorahModel>(
                  value: item,
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: currentSurah,
        onChanged: (value) {
          setState(() {
            currentSurah = value ?? _SorahModel(1);
            ayaStart = 1;
            ayaEnd = quran.getVerseCount(value?.id ?? 1);
          });
        },
        isExpanded: true,
      );

  // list aya start
  Widget dropDownAyaStart() => SizedBox(
        width: 100,
        child: DropdownButtonFormField<int>(
          decoration: const InputDecoration(
            label: Text("اية البداية"),
          ),
          items: [
            for (int i = 1;
                i <= quran.getVerseCount(currentSurah?.id ?? 1);
                i++)
              i
          ]
              .map((item) => DropdownMenuItem<int>(
                    value: item,
                    child: Text(
                      item.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: ayaStart,
          onChanged: (value) {
            setState(() {
              ayaStart = value;
              ayaEnd = null;
            });
          },
          isExpanded: true,
        ),
      );

  // list aya end
  Widget dropDownAyaEnd() => SizedBox(
        width: 100,
        child: DropdownButtonFormField<int>(
          decoration: const InputDecoration(
            label: Text("اية النهاية"),
          ),
          items: [
            for (int i = ayaStart ?? 1;
                i <= quran.getVerseCount(currentSurah?.id ?? 1);
                i++)
              i
          ]
              .map((item) => DropdownMenuItem<int>(
                    value: item,
                    child: Text(
                      item.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: ayaEnd,
          onChanged: (value) {
            setState(() {
              ayaEnd = value;
            });
          },
          isExpanded: true,
        ),
      );
}

class _SorahModel {
  int id;

  _SorahModel(this.id);

  get name => quran.getSurahNameArabic(id);
}
