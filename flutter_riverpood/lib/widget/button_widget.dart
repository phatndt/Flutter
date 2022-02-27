import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Theme.of(context).colorScheme.secondary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(color: Colors.white),
        ),
        onPressed: onClicked,
      );
}
