// class Pet {
// 	int? id;
// 	int? userId;
// 	String? name;
// 	int? age;
// 	String? type;
// 	String? gender;
// 	String? breed;
// 	String? picture;
// 	DateTime? createdAt;
// 	DateTime? updatedAt;

// 	Pet({
// 		this.id, 
// 		this.userId, 
// 		this.name, 
// 		this.age, 
// 		this.type, 
// 		this.gender, 
// 		this.breed, 
// 		this.picture, 
// 		this.createdAt, 
// 		this.updatedAt, 
// 	});

// 	factory Pet.fromJson(Map<String, dynamic> json) {
// 		return Pet(
// 			id: json['id'] as int?,
// 			userId: json['user_id'] as int?,
// 			name: json['name'] as String?,
// 			age: json['age'] as int?,
// 			type: json['type'] as String?,
// 			gender: json['gender'] as String?,
// 			breed: json['breed'] as String?,
// 			picture: json['picture'] as String?,
// 			createdAt: json['created_at'] == null
// 						? null
// 						: DateTime.parse(json['created_at'] as String),
// 			updatedAt: json['updated_at'] == null
// 						? null
// 						: DateTime.parse(json['updated_at'] as String),
// 		);
// 	}



// 	Map<String, dynamic> toJson() {
// 		return {
// 			'id': id,
// 			'user_id': userId,
// 			'name': name,
// 			'age': age,
// 			'type': type,
// 			'gender': gender,
// 			'breed': breed,
// 			'picture': picture,
// 			'created_at': createdAt?.toIso8601String(),
// 			'updated_at': updatedAt?.toIso8601String(),		};
// 	}
// }
