import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpood/widget/text_widget.dart';

Future<String> fetchValue() async {
  await Future.delayed(const Duration(seconds: 3));

  return 'State will be disposed!';
}

final futureProvider =
    FutureProvider.autoDispose<String>((ref) => fetchValue());

class AutoDisposeModifierPage extends ConsumerWidget {
  const AutoDisposeModifierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(futureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoDispose Modifier'),
      ),
      body: Center(
        child: future.when(
          data: (value) => Padding(
            padding: const EdgeInsets.all(48),
            child: TextWidget(text: value.toString()),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (e, stack) => TextWidget(text: 'Error: $e'),
        ),
      ),
    );
  }
}
