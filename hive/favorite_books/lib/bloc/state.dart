abstract class UIState {}

class UIInitialState extends UIState {}

class ReadFavoriteBook extends UIState {
  final List<String> favoriteBooks;

  ReadFavoriteBook(this.favoriteBooks);
}

class WriteFavoriteBook extends UIState {}
