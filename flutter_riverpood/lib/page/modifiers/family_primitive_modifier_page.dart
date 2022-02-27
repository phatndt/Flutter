import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpood/page/modifiers/user_helper.dart';
import 'package:flutter_riverpood/widget/text_widget.dart';
import 'package:flutter_riverpood/widget/user_widget.dart';

Future<User> fetchUser(String username) async {
  await Future.delayed(const Duration(milliseconds: 400));

  return users.firstWhere((user) => user.name == username);
}

final userProvider = FutureProvider.family<User, String>(
    (ref, username) async => fetchUser(username));

class FamilyPrimitiveModifierPage extends StatefulWidget {
  const FamilyPrimitiveModifierPage({Key? key}) : super(key: key);

  @override
  _FamilyPrimitiveModifierPageState createState() =>
      _FamilyPrimitiveModifierPageState();
}

class _FamilyPrimitiveModifierPageState
    extends State<FamilyPrimitiveModifierPage> {
  String username = users.first.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FamilyPrimitive Modifier'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              child: Consumer(builder: (context, watch, child) {
                final future = watch.watch(userProvider(username));

                return future.when(
                  data: (user) => UserWidget(user: user),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, stack) =>
                      const Center(child: TextWidget(text: 'Not found')),
                );
              }),
            ),
            const SizedBox(height: 32),
            buildSearch(),
          ],
        ),
      ),
    );
  }

  Widget buildSearch() => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Search',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            buildUsernameDropdown(),
          ],
        ),
      );

  Widget buildUsernameDropdown() => Row(
        children: [
          const Text(
            'Username',
            style: TextStyle(fontSize: 24),
          ),
          const Spacer(),
          DropdownButton<String>(
            value: username,
            iconSize: 32,
            style: const TextStyle(fontSize: 24, color: Colors.black),
            onChanged: (value) => setState(() => username = value!),
            items: users
                .map((user) => user.name)
                .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ))
                .toList(),
          ),
        ],
      );
}
