import 'package:flutter/material.dart';
import 'package:khetma/presentation/resources/theme_manager.dart';
import '../resources/icons_manager.dart';

class TempView extends StatefulWidget {
  const TempView({Key? key}) : super(key: key);

  @override
  State<TempView> createState() => _TempViewState();
}

class _TempViewState extends State<TempView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...texts(),

            const TextField(),
            const SizedBox(
              height: 20,
            ),
            const TextField(),
            const SizedBox(
              height: 20,
            ),
            const TextField(
              decoration:
                  InputDecoration(errorText: "AppStrings.passwordError"),
            ),
            const SizedBox(
              height: 20,
            ),
            // --------
            const Icon(IconsManager.filterList),
            const Icon(IconsManager.options),
            const Icon(IconsManager.list),
          ],
        ),
      )),
    );
  }

  List<Widget> texts() => [
        Text(
          "displayLarge",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          "displayLarge",
          style: ThemeManager.currentThem.textTheme.displayLarge,
        ),
        Text(
          "displayMedium",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text(
          "displaySmall",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "headlineLarge",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          "headlineMedium",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          "headlineSmall",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "titleLarge",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "titleMedium text field",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          "titleSmall",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "labelLarge",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          "labelMedium",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Text(
          "labelSmall",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "bodyLarge",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          "bodyMedium",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          "bodySmall",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Text(
          "normal normal",
        ),
      ];
}
