import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final stateProvider = StateProvider<int>(
  (ref) => 0,
);

class StateProviderPage extends ConsumerWidget {
  const StateProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(stateProvider);
    final counter = provider.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('StateProvider'),
      ),
      body: Center(child: Text(counter)),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          //ref.read(stateProvider.notifier).state++;
          ref.read(stateProvider.notifier).update((state) => state + 1);
        },
      ),
    );
  }
}
