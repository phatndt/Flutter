import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnvironmentCofig {
  final movieApiKey = const String.fromEnvironment("movieApiKey");
}

final environmentConfigProvider =
    Provider<EnvironmentCofig>(((ref) => EnvironmentCofig()));
