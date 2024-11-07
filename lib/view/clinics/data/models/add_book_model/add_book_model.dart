
class AddBookModel {
  late bool status;
  late String message;
  UserData? data;

  AddBookModel({
    required this.status,
    required this.message,
    this.data,
  });

  AddBookModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // Check if 'data' is a Map and not null
    if (json['data'] != null && json['data'] is Map<String, dynamic>) {
      data = UserData.fromJson(json['data']);
    } else {
      data = null;
    }
  }
}

class UserData {
  late Book? book;

  UserData({required this.book});

  UserData.fromJson(Map<String, dynamic> json) {
    book = json['book'] != null && json['book'] is Map<String, dynamic>
        ? Book.fromJson(json['book'])
        : null;
  }
}

class Book {
  late String time;
  late int id;

  Book({
    required this.time,
    required this.id,
  });

  Book.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    id = json['id'];
  }
}
