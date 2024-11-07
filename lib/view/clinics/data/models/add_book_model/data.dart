// import 'book.dart';
// import 'pet.dart';
// import 'user.dart';

// class Data {
// 	Book? book;
// 	List<Pet>? pets;
// 	User? user;

// 	Data({this.book, this.pets, this.user});

// 	factory Data.fromJson(Map<String, dynamic> json) {
// 		return Data(
// 			book: json['book'] == null
// 						? null
// 						: Book.fromJson(json['book'] as Map<String, dynamic>),
// 			pets: (json['pets'] as List<dynamic>?)
// 						?.map((e) => Pet.fromJson(e as Map<String, dynamic>))
// 						.toList(),
// 			user: json['user'] == null
// 						? null
// 						: User.fromJson(json['user'] as Map<String, dynamic>),
// 		);
// 	}



// 	Map<String, dynamic> toJson() {
// 		return {
// 			'book': book?.toJson(),
// 			'pets': pets?.map((e) => e.toJson()).toList(),
// 			'user': user?.toJson(),		};
// 	}
// }
