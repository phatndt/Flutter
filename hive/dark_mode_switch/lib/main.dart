import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

const darkModeBoxName = 'darkModeTutorial';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(darkModeBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Box darkModeBox = Hive.box(darkModeBoxName);
    return ValueListenableBuilder(
      valueListenable: Hive.box(darkModeBoxName).listenable(),
      builder: (context, box, widget) {
        var darkMode = darkModeBox.get('darkMode', defaultValue: false);
        return MaterialApp(
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          home: Scaffold(
            body: Center(
              child: Switch(
                value: darkMode,
                onChanged: (val) {
                  darkModeBox.put('darkMode', !darkMode);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
