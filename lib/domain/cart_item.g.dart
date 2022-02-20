// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) => CartItem(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      url: json['url'] as String,
    );

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'url': instance.url,
    };
