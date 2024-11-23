// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      image: json['image'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'description': instance.description,
      'quantity': instance.quantity,
    };
