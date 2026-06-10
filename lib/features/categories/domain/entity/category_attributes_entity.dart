class CategoryAttributesEntity {
  final int id;
  final String name;
  final List<AttributesValueEntity> values;
  const CategoryAttributesEntity({required this.id, required this.name,required this.values});
}
class AttributesValueEntity {
  final int id;
  final String value;
  final String? code;

  const AttributesValueEntity({required this.id, required this.value, this.code});
}
