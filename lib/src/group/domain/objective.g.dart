// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'objective.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Objective _$ObjectiveFromJson(Map<String, dynamic> json) => Objective(
      unit: json['unit'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$ObjectiveToJson(Objective instance) => <String, dynamic>{
      'unit': instance.unit,
      'quantity': instance.quantity,
    };
