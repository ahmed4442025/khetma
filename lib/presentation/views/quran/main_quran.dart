import 'package:flutter/material.dart';
import 'package:khetma/presentation/views/quran/views/all_joz.dart';
import 'package:khetma/presentation/views/quran/views/all_sorah.dart';
import 'package:khetma/presentation/views/quran/views/favorites/group_quran_groups.dart';

class MainQuraView extends StatelessWidget {
  MainQuraView({Key? key}) : super(key: key);

  List<_PageInfo> _pages() => [
        _PageInfo("السور", AllSurahView()),
        _PageInfo("الأجزاء", AllJozView()),
        _PageInfo("الأوراد", QuranMyGroup()),
      ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _pages().length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: TabBar(
              tabs: _pages()
                  .map((e) => Tab(
                        child: Text(
                          e.label,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ))
                  .toList()),
        ),
        body: TabBarView(children: _pages().map((e) => e.child).toList()),
      ),
    );
  }
}

class _PageInfo {
  String label;
  Widget child;

  _PageInfo(this.label, this.child);
}
