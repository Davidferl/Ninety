// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      groupId: json['groupId'] as String,
      userId: json['userId'] as String,
      objective: Objective.fromJson(json['objective'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'groupId': instance.groupId,
      'userId': instance.userId,
      'objective': instance.objective,
    };
