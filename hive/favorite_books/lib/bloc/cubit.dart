import 'package:bloc/bloc.dart';
import 'package:favorite_books/bloc/state.dart';
import 'package:favorite_books/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteBooksCubit extends Cubit<UIState> {
  FavoriteBooksCubit() : super(UIInitialState());

  Future<void> readFavoriteBooks() async {
    Box<String> favoriteBooksBox = Hive.box(favoritesBox);
    emit(ReadFavoriteBook(favoriteBooksBox.values.toList()));
  }

  Future<void> writingFavoriteBooks(List<String> favoriteBooks) async {
    Box<String> favoriteBooksBox = Hive.box(favoritesBox);
    await favoriteBooksBox.addAll(favoriteBooks);
  }
}
