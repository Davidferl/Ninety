// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      userId: json['userId'] as String,
      objective: Objective.fromJson(json['objective'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'userId': instance.userId,
      'objective': instance.objective,
    };
