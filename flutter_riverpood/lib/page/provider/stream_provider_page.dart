import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamProvider = StreamProvider.autoDispose<String>(
  (ref) =>
      Stream.periodic(const Duration(milliseconds: 400), (count) => '$count'),
);

class StreamProviderPage extends ConsumerWidget {
  const StreamProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamBuilder'),
      ),
      body: Center(
        child: buildStreamWhen(ref),
      ),
    );
  }

  buildStreamWhen(WidgetRef ref) {
    final stream = ref.watch(streamProvider);

    return stream.when(
      data: (value) => Text(
        value.toString(),
      ),
      error: (e, stack) => Text(
        e.toString(),
      ),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
