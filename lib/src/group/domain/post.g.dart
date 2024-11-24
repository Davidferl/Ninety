// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String?,
      groupId: json['groupId'] as String,
      memberId: json['memberId'] as String,
      image: json['image'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      reactions: (json['reactions'] as List<dynamic>?)
          ?.map((e) => Reaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      quantity: (json['quantity'] as num).toDouble(),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'groupId': instance.groupId,
      'memberId': instance.memberId,
      'image': instance.image,
      'title': instance.title,
      'description': instance.description,
      'reactions': instance.reactions,
      'timestamp': instance.timestamp.toIso8601String(),
      'quantity': instance.quantity,
    };

Reaction _$ReactionFromJson(Map<String, dynamic> json) => Reaction(
      userId: json['userId'] as String,
      emoji: json['emoji'] as String?,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$ReactionToJson(Reaction instance) => <String, dynamic>{
      'userId': instance.userId,
      'emoji': instance.emoji,
      'comment': instance.comment,
    };
