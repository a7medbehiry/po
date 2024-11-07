import 'pet.dart';

class Data {
  List<Pet>? pets;

  Data({this.pets});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      pets: (json['pets'] as List<dynamic>?)
          ?.map((e) => Pet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pets': pets?.map((e) => e.toJson()).toList(),
    };
  }
}
