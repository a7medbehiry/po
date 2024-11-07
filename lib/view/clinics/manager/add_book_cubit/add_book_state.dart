part of 'add_book_cubit.dart';

@immutable
sealed class AddBookState {}

final class AddBookInitial extends AddBookState {}

final class AddBookLoading extends AddBookState {}

final class AddBookSuccess extends AddBookState {
  final AddBookModel addBookModel;

  AddBookSuccess({required this.addBookModel});
}

final class AddBookFailure extends AddBookState {
  final String message;

  AddBookFailure({required this.message});
}
