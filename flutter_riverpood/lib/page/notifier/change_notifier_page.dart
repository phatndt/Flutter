import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpood/widget/button_widget.dart';
import 'package:flutter_riverpood/widget/text_widget.dart';

class CarNotifier extends ChangeNotifier {
  int _speed = 120;

  void increase() {
    _speed += 5;

    notifyListeners();
  }

  void hitBreak() {
    _speed = max(0, _speed - 30);

    notifyListeners();
  }
}

final carProvider =
    ChangeNotifierProvider<CarNotifier>(((ref) => CarNotifier()));

class ChangeNotifierPage extends ConsumerWidget {
  const ChangeNotifierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final car = ref.watch(carProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeNotifierProvider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(text: 'Speed: ${car._speed}'),
            const SizedBox(height: 8),
            buildButtons(context, car),
          ],
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context, CarNotifier car) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonWidget(
            text: 'Increase +5',
            onClicked: car.increase,
          ),
          // car.increase: not efficient
          // => button rebuilds everytime if car state changes
          const SizedBox(width: 12),
          ButtonWidget(
            text: 'Hit Brake -30',
            onClicked: car.hitBreak,
          ),
        ],
      );
}
