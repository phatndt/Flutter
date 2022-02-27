import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scopedProvider = Provider<int>((ref) => throw UnimplementedError());

class ScopedProviderPage extends StatelessWidget {
  const ScopedProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScopedProvider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildScoped(42),
            buildScoped(90),
            buildScoped(0),
          ],
        ),
      ),
    );
  }

  Widget buildScoped([int? value]) {
    final consumer = Consumer(
      builder: (context, ref, child) {
        final number = ref.watch(scopedProvider).toString();

        return Text(number);
      },
    );

    return value == null
        ? consumer
        : ProviderScope(
            overrides: [scopedProvider.overrideWithValue(value)],
            child: consumer);
  }
}
