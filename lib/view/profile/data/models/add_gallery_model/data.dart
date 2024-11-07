import 'pet_image.dart';

class Data {
  List<List<PetImage>>? petImages;

  Data({this.petImages});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      petImages: (json['petImages'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => PetImage.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'petImages': petImages?.map((e) => e.map((e) => e.toJson()).toList()).toList(),
    };
  }
}
