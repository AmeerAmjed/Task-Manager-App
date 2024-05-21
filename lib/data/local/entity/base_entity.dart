abstract class BaseEntity {
  final int? id;

  BaseEntity(this.id);

  Map<String, dynamic> toMap();
}
