import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpood/page/modifiers/auto_dispose_modifier_page.dart';
import 'package:flutter_riverpood/page/modifiers/family_object_modifier_page.dart';
import 'package:flutter_riverpood/page/modifiers/family_primitive_modifier_page.dart';
import 'package:flutter_riverpood/page/notifier/change_notifier_page.dart';
import 'package:flutter_riverpood/page/notifier/state_notifier_page.dart';
import 'package:flutter_riverpood/page/provider/combined_providers_page.dart';
import 'package:flutter_riverpood/page/provider/future_provider_page.dart';
import 'package:flutter_riverpood/page/provider/provider_page.dart';
import 'package:flutter_riverpood/page/provider/scoped_provider_page.dart';
import 'package:flutter_riverpood/page/provider/state_provider_page.dart';
import 'package:flutter_riverpood/page/provider/stream_provider_page.dart';
import 'package:flutter_riverpood/widget/button_widget.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String title = 'Riverpod Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(MyApp.title)),
      body: Center(child: buildPages()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Text('Riverpod', style: TextStyle(color: Colors.white)),
            label: 'Providers',
          ),
          BottomNavigationBarItem(
            icon: Text('Riverpod', style: TextStyle(color: Colors.white)),
            label: 'Notifiers',
          ),
          BottomNavigationBarItem(
            icon: Text('Riverpod', style: TextStyle(color: Colors.white)),
            label: 'Modifiers',
          ),
        ],
        onTap: (int index) => setState(() {
          this.index = index;
        }),
      ),
    );
  }

  Widget buildPages() {
    switch (index) {
      case 0:
        return buildProviderPage(context);
      case 1:
        return buildNotifiersPage(context);
      case 2:
        return buildModifiersPage(context);
      default:
        return Container();
    }
  }

  Widget buildProviderPage(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonWidget(
            text: 'Provider',
            onClicked: () => navigateTo(context, const ProviderPage()),
          ),
          const SizedBox(height: 12),
          ButtonWidget(
            text: 'StateProvider',
            onClicked: () => navigateTo(context, const StateProviderPage()),
          ),
          const SizedBox(height: 12),
          ButtonWidget(
            text: 'FutureProvider',
            onClicked: () => navigateTo(context, const FutureProviderPage()),
          ),
          const SizedBox(height: 12),
          ButtonWidget(
            text: 'StreamProvider',
            onClicked: () => navigateTo(context, const StreamProviderPage()),
          ),
          const SizedBox(height: 12),
          ButtonWidget(
            text: 'ScopedProvider',
            onClicked: () => navigateTo(context, const ScopedProviderPage()),
          ),
          const SizedBox(height: 12),
          ButtonWidget(
            text: 'Combined Providers',
            onClicked: () => navigateTo(context, const CombinedProvidersPage()),
          ),
        ],
      );

  Widget buildNotifiersPage(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonWidget(
            text: 'StateNotifierProvider',
            onClicked: () => navigateTo(context, const StateNotifierPage()),
          ),
          const SizedBox(height: 32),
          ButtonWidget(
            text: 'ChangeNotifierProvider',
            onClicked: () => navigateTo(context, const ChangeNotifierPage()),
          ),
        ],
      );

  Widget buildModifiersPage(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonWidget(
            text: 'Family Primitive',
            onClicked: () =>
                navigateTo(context, const FamilyPrimitiveModifierPage()),
          ),
          const SizedBox(height: 12),
          ButtonWidget(
            text: 'Family Object',
            onClicked: () =>
                navigateTo(context, const FamilyObjectModifierPage()),
          ),
          const SizedBox(height: 12),
          ButtonWidget(
            text: 'Auto-Dispose',
            onClicked: () =>
                navigateTo(context, const AutoDisposeModifierPage()),
          ),
        ],
      );

  void navigateTo(BuildContext context, Widget page) =>
      Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => page),
      );
}
