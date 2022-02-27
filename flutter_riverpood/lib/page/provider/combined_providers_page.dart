import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cityProvider = Provider<String>((ref) => 'Munich22');

Future<int> fetchWeather(String city) async {
  await Future.delayed(const Duration(seconds: 2));

  return city == 'Munich' ? 20 : 15;
}

final futureProvider = FutureProvider<int>((ref) async {
  final city = ref.watch(cityProvider);

  return fetchWeather(city);
});

class CombinedProvidersPage extends ConsumerWidget {
  const CombinedProvidersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(futureProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ScopedProvider'),
      ),
      body: Center(
        child: future.when(
          data: (value) => Text(
            value.toString(),
          ),
          error: (e, stack) => Text(
            e.toString(),
          ),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
