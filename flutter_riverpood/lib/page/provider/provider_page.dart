import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final numberProvider = Provider<int>(
  (ref) => 42,
);

class ProviderPage extends ConsumerWidget {
  const ProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final number = ref.watch(numberProvider).toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider'),
      ),
      body: Center(child: Text(number)),
    );
  }
}
