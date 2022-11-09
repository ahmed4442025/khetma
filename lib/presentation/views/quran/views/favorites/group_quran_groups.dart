import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khetma/domain/models/cache_models.dart';
import 'package:khetma/presentation/resources/views_manager.dart';
import 'package:khetma/presentation/util/util_manager.dart';
import 'package:quran/quran.dart' as quran;
import '../../../../../controllers/home/home_bloc.dart';
import '../../../../../domain/models/faqra.dart';

class QuranMyGroup extends StatelessWidget {
  QuranMyGroup({Key? key}) : super(key: key);
  Map<int, bool> currentIndexViewed = {};
  late HomeBloc _bloc;

  @override
  Widget build(BuildContext context) {
    _bloc = HomeBloc.get(context);
    return Scaffold(
      body: myBody(),
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: fab(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  FloatingActionButton fab(context) => FloatingActionButton(
        onPressed: () => ViewsManager.addNewGroup(context),
        child: const Icon(Icons.add),
      );

  Widget myBody() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (p, c) {
              return c is HSGroupChange;
            },
            builder: (context, state) {
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (c, i) => build1Group(_bloc.allGroups.listGroups[i], i, c),
                  separatorBuilder: (c, i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                  itemCount: _bloc.allGroups.listGroups.length);
            },
          ),
        ),
      );

  Widget build1Group(GroupQuran groupQuran, int index, context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () => deleteGroup(index),
                            child: Icon(Icons.delete,
                                color: Colors.teal.shade900)),
                        UtilM.box10(),
                        // name
                        InkWell(
                          onTap: () => openGroup(context, index),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                groupQuran.name,
                                style: TextStyle(color: Colors.teal.shade900),
                              ),
                              if (HomeBloc.get(context).lastGroupModel?.id ==
                                  index)
                                lastRead()
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // edit
                        InkWell(
                            onTap: () => editGroup(context, index),
                            child: Icon(Icons.mode_rounded,
                                color: Colors.teal.shade900)),
                        UtilM.box15(),
                        // show more
                        InkWell(
                          onTap: () => showMore(index),
                          child: Icon(
                              (currentIndexViewed[index] ?? false)
                                  ? Icons.arrow_drop_down_outlined
                                  : Icons.arrow_left_outlined,
                              size: 30,
                              color: Colors.teal.shade900),
                        ),
                      ],
                    ),
                  ],
                )),
            if (currentIndexViewed[index] ?? false)
              detailsGroup(groupQuran.faqraModel.listSurah)
          ],
        ),
      );

  Widget detailsGroup(List<FaqraSurahModel> listSurah) {
    const String from = "من الأية";
    const String to = "إالي الاية";
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < listSurah.length; i++) ...[
          Text(
              "${quran.getSurahNameArabic(listSurah[i].id)} $from   (${listSurah[i].ayaStart})   $to  (${listSurah[i].ayaEnd})")
        ]
      ],
    );
  }

  Widget lastRead() => const Text(
        "last read",
        style: TextStyle(color: Colors.lightGreen),
      );

  // voids
  void showMore(int index) {
    currentIndexViewed[index] = !(currentIndexViewed[index] ?? false);
    _bloc.reFreshGroup();
  }

  void editGroup(context, int index) {
    ViewsManager.addNewGroup(context, groupIndex: index);
  }

  void openGroup(context, int index) {
    ViewsManager.QuranContentWB(context, _bloc.allGroups.listGroups[index].faqraModel);
    _bloc.changeLastGroupRead(CacheLastGroupModel(index));
  }

  void deleteGroup(int index) {
    _bloc.deleteGroup(index);
  }
}
