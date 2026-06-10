
import '../../domain/entity/attribute_entity.dart';

class AttributeValeModel extends AttributeValeEntity{
  AttributeValeModel({required super.id, required super.value, required super.code});
  
  factory AttributeValeModel.fromJson(Map data){
    return AttributeValeModel(id: data['id'], value: data['value'], code: data['code']);
  }
  
}

class AttributeModel extends AttributeEntity{
  AttributeModel({required super.id, required super.name, required super.values});
  
  factory AttributeModel.fromJson(Map data){
    List<AttributeValeModel> values = [];
    if(data.containsKey('values')){
      for(var i in data['values']){
        values.add(AttributeValeModel.fromJson(i));
      }
    }
    return AttributeModel(
      id: data['id'],
      name: data['name'],
      values: values,
    );
  }
  
}