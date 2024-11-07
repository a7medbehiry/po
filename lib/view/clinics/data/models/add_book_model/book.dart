// class Book {
// 	int? userId;
// 	String? clinicId;
// 	String? time;
// 	DateTime? updatedAt;
// 	DateTime? createdAt;
// 	int? id;

// 	Book({
// 		this.userId, 
// 		this.clinicId, 
// 		this.time, 
// 		this.updatedAt, 
// 		this.createdAt, 
// 		this.id, 
// 	});

// 	factory Book.fromJson(Map<String, dynamic> json) {
// 		return Book(
// 			userId: json['user_id'] as int?,
// 			clinicId: json['clinic_id'] as String?,
// 			time: json['time'] as String?,
// 			updatedAt: json['updated_at'] == null
// 						? null
// 						: DateTime.parse(json['updated_at'] as String),
// 			createdAt: json['created_at'] == null
// 						? null
// 						: DateTime.parse(json['created_at'] as String),
// 			id: json['id'] as int?,
// 		);
// 	}



// 	Map<String, dynamic> toJson() {
// 		return {
// 			'user_id': userId,
// 			'clinic_id': clinicId,
// 			'time': time,
// 			'updated_at': updatedAt?.toIso8601String(),
// 			'created_at': createdAt?.toIso8601String(),
// 			'id': id,		};
// 	}
// }
