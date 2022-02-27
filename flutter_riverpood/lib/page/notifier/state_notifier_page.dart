import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpood/widget/button_widget.dart';
import 'package:flutter_riverpood/widget/text_widget.dart';

class Car {
  final int speed;
  final int doors;

  const Car({
    this.speed = 120,
    this.doors = 4,
  });

  Car copy({int? speed, int? doors}) => Car(
        speed: speed ?? this.speed,
        doors: doors ?? this.doors,
      );
}

class CarNotifier extends StateNotifier<Car> {
  CarNotifier() : super(const Car());

  void setDoors(int doors) {
    final newState = state.copy(doors: doors);
    state = newState;
  }

  void increaseSpeed() {
    final speed = state.speed + 5;
    final newState = state.copy(speed: speed);
    state = newState;
  }

  void hitBrake() {
    final speed = max(0, state.speed - 30);
    final newState = state.copy(speed: speed);
    state = newState;
  }
}

final stateNotifierProvider =
    StateNotifierProvider<CarNotifier, Car>(((ref) => CarNotifier()));

class StateNotifierPage extends ConsumerWidget {
  const StateNotifierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final car = ref.watch(stateNotifierProvider);
    final speed = car.speed;
    final doors = car.doors;

    final carNotifier = ref.watch(stateNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('StateNotifierProvider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(text: 'Speed: $speed'),
            const SizedBox(height: 8),
            TextWidget(text: 'Doors: $doors'),
            const SizedBox(height: 32),
            buildButtons(ref),
            const SizedBox(height: 32),
            Slider(
              value: car.doors.toDouble(),
              max: 5,
              onChanged: (value) => carNotifier.setDoors(value.toInt()),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButtons(WidgetRef ref) {
    final carNotifier = ref.watch(stateNotifierProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonWidget(text: 'Increase +5', onClicked: carNotifier.increaseSpeed),
        const SizedBox(width: 12),
        ButtonWidget(text: 'Hit Brake -30', onClicked: carNotifier.hitBrake),
      ],
    );
  }
}
