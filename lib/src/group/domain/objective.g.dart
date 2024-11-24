// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objective.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Objective _$ObjectiveFromJson(Map<String, dynamic> json) => Objective(
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      unit: json['unit'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      quantityType: $enumDecode(_$QuantityTypeEnumMap, json['quantityType'],
          unknownValue: QuantityType.discrete),
    );

Map<String, dynamic> _$ObjectiveToJson(Objective instance) => <String, dynamic>{
      'posts': instance.posts,
      'unit': instance.unit,
      'quantity': instance.quantity,
      'quantityType': _$QuantityTypeEnumMap[instance.quantityType]!,
    };

const _$QuantityTypeEnumMap = {
  QuantityType.discrete: 'discrete',
  QuantityType.continuous: 'continuous',
};
