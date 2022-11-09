import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khetma/controllers/home/home_bloc.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  late HomeBloc _bloc;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    _bloc = HomeBloc.get(context);
    return SafeArea(
        child: Directionality(textDirection: TextDirection.rtl, child: gg()));
  }

  Widget gg() => Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) => {_bloc.changePageIndex(index)},
            children: _bloc.pages.map((e) => e.widget).toList(),
          ),
        ),
        bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (p, c) => c is HSPageIndex,
          builder: (context, state) {
            return BottomNavyBar(
              selectedIndex: _bloc.currentPageIndex,
              onItemSelected: (index) {
                _bloc.changePageIndex(index);
                _pageController.jumpToPage(index);
              },
              items:
                  _bloc.pages.map((e) => oneNavyItem(e.label, e.icon)).toList(),
            );
          },
        ),
      );

  BottomNavyBarItem oneNavyItem(String label, IconData icon) =>
      BottomNavyBarItem(title: Center(child: Text(label)), icon: Icon(icon));
}
