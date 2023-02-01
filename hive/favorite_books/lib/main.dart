import 'dart:developer';

import 'package:favorite_books/bloc/cubit.dart';
import 'package:favorite_books/bloc/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

const favoritesBox = 'favorite_books';
const List<String> books = [
  'Harry Potter',
  'To Kill a Mockingbird',
  'The Hunger Games',
  'The Giver',
  'Brave New World',
  'Unwind',
  'World War Z',
  'The Lord of the Rings',
  'The Hobbit',
  'Moby Dick',
  'War and Peace',
  'Crime and Punishment',
  'The Adventures of Huckleberry Finn',
  'Catch-22',
  'The Sound and the Fury',
  'The Grapes of Wrath',
  'Heart of Darkness',
];

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>(favoritesBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => FavoriteBooksCubit()..readFavoriteBooks(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late final FavoriteBooksCubit _favoriteBooksCubit = context.read();
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future _init() async {
    // await _favoriteBooksCubit.readFavoriteBooks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: const [
            MyWidget(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<FavoriteBooksCubit>().writingFavoriteBooks(books);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBooksCubit, UIState>(
      builder: (context, state) {
        if (state is ReadFavoriteBook) {
          return Expanded(
            child: RefreshIndicator(
              onRefresh: () =>
                  context.read<FavoriteBooksCubit>().readFavoriteBooks(),
              child: ListView.builder(
                itemCount: state.favoriteBooks.length,
                itemBuilder: (context, index) {
                  return Text(state.favoriteBooks[index]);
                },
              ),
            ),
          );
        }
        return Container(
          color: Colors.amber,
        );
      },
      buildWhen: ((previous, current) {
        if (previous is ReadFavoriteBook && current is ReadFavoriteBook) {
          return listEquals(previous.favoriteBooks, current.favoriteBooks) !=
              true;
        }
        return true;
      }),
    );
  }
}
