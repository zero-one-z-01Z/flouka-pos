class AttributeEntity{
  int id;
  String name;
  List<AttributeValeEntity> values;
  AttributeEntity({required this.id,required this.name,required this.values});

}

class AttributeValeEntity{
  int id;
  String value;
  String? code;

  AttributeValeEntity({required this.id,required this.value,required this.code});
}