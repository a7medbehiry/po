import 'pet.dart';

class Data {
  List<Animal>? pets;

  Data({this.pets});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      pets: (json['pets'] as List<dynamic>?)
          ?.map((e) => Animal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pets': pets?.map((e) => e.toJson()).toList(),
    };
  }
}
