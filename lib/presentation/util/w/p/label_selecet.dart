import 'package:flutter/material.dart';
import 'package:khetma/presentation/resources/theme_manager.dart';

class LabelSelectedList extends StatefulWidget {
  List<LabelSelectedModel> _listLabels;

  LabelSelectedList(this._listLabels, {Key? key}) : super(key: key);

  @override
  State<LabelSelectedList> createState() => _LabelSelectedListState();
}

class _LabelSelectedListState extends State<LabelSelectedList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget._listLabels.length,
        itemBuilder: (BuildContext context, int index) {
          return _LabelSelected(
            labelSelectedModel: widget._listLabels[index],
            index: index,
            onTap: (x) {
              print(x);
              for (int i = 0; i < widget._listLabels.length; i++) {
                widget._listLabels[i].isSelected = i == x;
              }
              setState(() {});
            },
          );
        },
      ),
    );
  }
}

class _LabelSelected extends StatelessWidget {
  final LabelSelectedModel _labelSelectedModel;
  final void Function(int value) onTap;
  final int index;

  const _LabelSelected(
      {Key? key,
      required LabelSelectedModel labelSelectedModel,
      required this.onTap,
      required this.index})
      : _labelSelectedModel = labelSelectedModel,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _labelSelectedModel.name,
            style: TextStyle(
                fontSize: _labelSelectedModel.isSelected ? 18 : 18,
                fontWeight: FontWeight.bold,
                color: _labelSelectedModel.isSelected
                    ? ThemeManager.c.fontMain
                    : ThemeManager.c.fontLight),
          ),
          Container(
            height: _labelSelectedModel.isSelected ? 6 : 1,
            width: 90,
            color: ThemeManager.c.primary,
          )
        ],
      ),
    );
  }
}

class LabelSelectedModel {
  String name;
  bool isSelected;

  LabelSelectedModel(this.name, {this.isSelected = false});
}
