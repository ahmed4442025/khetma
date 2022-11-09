import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khetma/domain/models/cache_models.dart';
import 'package:khetma/domain/repository/cache_repository.dart';
import 'package:khetma/presentation/views/quran/main_quran.dart';
import 'package:meta/meta.dart';

import '../../domain/models/faqra.dart';
import '../../presentation/views/khetma_view/khetma_home_view.dart';
import '../../presentation/views/more_view/more_view.dart';
import '../../presentation/views/tips_view/tips_home_view.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._cacheRepository) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
  }

  // final CacheRepository _cacheRepository= instance<CacheRepository>();
  final CacheRepository _cacheRepository;

  static HomeBloc get(context) => BlocProvider.of(context);

  // pages
  final List<PageInfo> pages = [
    PageInfo("القران", MainQuraView(), Icons.menu_book),
    PageInfo("ختمة", const KhetmaHomeView(), Icons.real_estate_agent_outlined),
    PageInfo("نصائح", const TipsHomeView(), Icons.tips_and_updates_outlined),
    PageInfo("المزيد", const MoreView(), Icons.apps),
  ];

  // init
  void init() async {
    // _cacheRepository = instance<CacheRepoSharedPref>();
    //     CacheRepoSharedPref(SharedPrefDSImpl(await SharedPreferences.getInstance()));
    _loadAllLastRead();
  }

  int currentPageIndex = 0;

  // scroll right and left => change the page
  void changePageIndex(int newIndex) {
    currentPageIndex = newIndex;
    emit(HSPageIndex());
  }

  // build children for page view
  List<Widget> get pageViwChildren => pages.map((e) => e.widget).toList();

  // ================= cache last read =================

  // vars
  late CacheLastSurahModel? lastSurahModel;
  late CacheLastJozModel? lastJozModel;
  late CacheLastGroupModel? lastGroupModel;

  // change last read
  void changeLastSurahRead(CacheLastSurahModel surah) async {
    lastSurahModel = surah;
    await _cacheRepository.setSurahLastSeen(surah);
    emit(HSLastRead());
  }

  void changeLastJozRead(CacheLastJozModel joz) async {
    lastJozModel = joz;
    await _cacheRepository.setJozLastSeen(joz);
    emit(HSLastRead());
  }

  void changeLastGroupRead(CacheLastGroupModel group) {
    lastGroupModel = group;
    _cacheRepository.setGroupLastSeen(group);
    emit(HSGroupChange());
  }

  // get last read
  void _loadAllLastRead() {
    _getLastSurah();
    _getLastJoz();
    _getLastGroup();
    _cacheRepository.getAllGroups().fold((l) {
      allGroups = CacheAllGroupModel([]);
      print("error : ${l.message}");
    }, (r) => allGroups = r);
  }

  void _getLastSurah() {
    (_cacheRepository.getSurahLastSeen())
        .fold((l) => null, (r) => lastSurahModel = r);
  }

  void _getLastJoz() {
    (_cacheRepository.getJozLastSeen())
        .fold((l) => null, (r) => lastJozModel = r);
  }

  void _getLastGroup() {
    (_cacheRepository.getGroupLastSeen())
        .fold((l) => null, (r) => lastGroupModel = r);
  }

  // ================= End cache last read =================

  // change Group
  late CacheAllGroupModel allGroups;

  void _setAllGroups() async {
    var res = await _cacheRepository.setAllGroups(allGroups);
    res.fold((l) => print(l.message), (r) => print("r : $r"));
    print(allGroups.toJson());
  }

  void deleteGroup(int index) {
    allGroups.listGroups.removeAt(index);
    if (lastGroupModel?.id == index){
      _cacheRepository.setGroupLastSeen(null);
      lastGroupModel = null;
    }
    _setAllGroups();
    reFreshGroup();
  }

  void addGroup(GroupQuran groupQuran) {
    print("add to group");
    allGroups.listGroups.add(groupQuran);
    _setAllGroups();
    reFreshGroup();
  }

  void editGroup(int index, GroupQuran newGroup) {
    allGroups.listGroups[index] = newGroup;
    _setAllGroups();
    reFreshGroup();
  }

  void reFreshGroup() {
    emit(HSGroupChange());
  }
}

class PageInfo {
  String label;
  Widget widget;
  IconData icon;

  PageInfo(this.label, this.widget, this.icon);
}
