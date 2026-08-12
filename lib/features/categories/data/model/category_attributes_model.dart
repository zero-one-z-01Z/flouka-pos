import '../../domain/entity/category_attributes_entity.dart';

class CategoryAttributesModel extends CategoryAttributesEntity {
  const CategoryAttributesModel({
    required super.id,
    required super.name,
    required super.values,
  });

  factory CategoryAttributesModel.fromJson(Map<String, dynamic> json) {
    final list = <AttributesValueModel>[];
    if (json['values'] != null) {
      for (final i in json['values']) {
        list.add(AttributesValueModel.fromJson(Map<String, dynamic>.from(i as Map)));
      }
    }
    return CategoryAttributesModel(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      name: _localized(json['name']),
      values: list,
    );
  }
}

class AttributesValueModel extends AttributesValueEntity {
  const AttributesValueModel({
    required super.id,
    required super.code,
    required super.value,
    super.hex,
  });

  factory AttributesValueModel.fromJson(Map<String, dynamic> json) {
    return AttributesValueModel(
      id: json['id'] is int ? json['id'] as int : int.tryParse('${json['id']}') ?? 0,
      code: json['code']?.toString(),
      value: _localized(json['name'] ?? json['value']),
      hex: json['hex']?.toString(),
    );
  }
}

String _localized(dynamic raw) {
  if (raw == null) return '';
  if (raw is String) {
    final t = raw.trim();
    if (t.startsWith('{') && t.contains(':')) {
      try {
        // Sometimes Spatie returns JSON string instead of decoded map.
        final decoded = raw; // already string — try crude extract for fr
        final fr = RegExp(r'"fr"\s*:\s*"([^"]*)"').firstMatch(t);
        if (fr != null) return fr.group(1)!;
        final en = RegExp(r'"en"\s*:\s*"([^"]*)"').firstMatch(t);
        if (en != null) return en.group(1)!;
      } catch (_) {}
    }
    return t;
  }
  if (raw is Map) {
    final fr = raw['fr'];
    final en = raw['en'];
    final ar = raw['ar'];
    if (fr != null) return fr.toString();
    if (en != null) return en.toString();
    if (ar != null) return ar.toString();
    if (raw.values.isNotEmpty) return raw.values.first.toString();
    return '';
  }
  return raw.toString();
}
