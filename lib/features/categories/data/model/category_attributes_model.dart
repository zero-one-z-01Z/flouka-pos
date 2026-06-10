import '../../domain/entity/category_attributes_entity.dart';

class CategoryAttributesModel extends CategoryAttributesEntity {
  const CategoryAttributesModel({required super.id, required super.name,required super.values});

  factory CategoryAttributesModel.fromJson(Map<String, dynamic> json) {
    List<AttributesValueModel>list=[];
    if(json['values'] != null){
     for(var i in json['values']){
       list.add(AttributesValueModel.fromJson(i));
     }
    }
    return CategoryAttributesModel(id: json['id'], name: json['name'],values: list);
  }
}
class AttributesValueModel extends AttributesValueEntity {
  const AttributesValueModel({required super.id, required super.code,required super.value});

  factory AttributesValueModel.fromJson(Map<String, dynamic> json) {
    return AttributesValueModel(id: json['id'], code: json['code'],value: json['name']);
  }
}
